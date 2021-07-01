From Coerciongraph Require Import Loader.
Variable set:Type.
Variable monoid:Type.
Variable group:Type.
Variable abelian_group:Type.
Variable abelian_monoid:Type.
Variable ring:Type.

Variable f1:monoid->set.
Coercion f1:monoid >-> set.

Variable f2:group->monoid.
Coercion f2:group>->monoid.

Variable f3:abelian_group -> group.
Coercion f3:abelian_group >-> group.

Variable f4:abelian_monoid -> monoid.
Coercion f4:abelian_monoid >-> monoid.

Variable f5:ring -> abelian_group.
Coercion f5:ring >-> abelian_group.

Variable f6:ring -> abelian_monoid.
Coercion f6:ring >-> abelian_monoid.

Variable f7:abelian_group -> abelian_monoid.
Coercion f7:abelian_group >-> abelian_monoid.

Coercions Graph "a".