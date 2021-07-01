open Pp 

(* default name for the dot file *)
let filename = ref "coercion_graph.dot"

(* parsing coersion as printed  by Print Graph *)

let coercions_regexp=Str.regexp "\\[\\([^]]+\\)\\] : \\([^ ]+\\) >-> \\([^ ]+\\)"

let mklistOfEdge s =
List.filter 
  (function x->let (edge,source,target)=x 
    in not (String.contains_from edge  0 ';'))
  (List.map (function x->begin ignore (Str.string_match coercions_regexp x 0);
     Str.matched_group 1  x, Str.matched_group 2  x, Str.matched_group 3  x; end)
      (Str.split (Str.regexp "\n") s)
  )
;;

(* start and end of graphviz dot files *)
let graphstart="digraph coercion_graph { \n\
  graph [ratio=1] \n  \
  node [style=filled] \n"

let graphend="\n}"

(* save content to filename *)
let save content =
    try
      let oc = open_out !filename  in
        Feedback.msg_notice (str "output coercions graph in file " ++ (str !filename));
        Printf.fprintf oc "%s\n" (graphstart^content^graphend);
        close_out oc
    with Sys_error msg ->
      CErrors.user_err (str "cannot open file: " ++ (str msg))
  
let builgraph s = 
    if (not (s="")) then filename :=s; 
    (* Feedback.msg_notice (Prettyp.print_classes()); *)
    (* Feedback.msg_notice (Prettyp.print_graph()) ; *)
    (* get the graph *)
    let ppt=Prettyp.print_graph() in
    (* make it a string *)
    let s=Pp.string_of_ppcmds ppt in
    (* parse and build the dot graph lines *)
    let ledge =(mklistOfEdge s) in
    let ledgeString = List.map
    (function x -> let (e,s,t)=x in 
        s^ "->"^t^" [ label="^e^" ] \n") 
    ledge in
    let r=String.concat "" ledgeString
      in 
      
      (* Feedback.msg_notice (Pp.str r) *)
      save(r)
  
