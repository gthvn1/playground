(* https://cs3110.github.io/textbook/chapters/ds/rb.html *)
(* https://courses.cs.cornell.edu/cs3110/2021sp/textbook/eff/bst.html *)

module type Tree = sig
  type 'a t

  val insert : 'a -> 'a t -> 'a t
  val remove : 'a -> 'a t -> 'a t
  val empty : 'a t
  val inorder : 'a t -> 'a list
end

(* A node is a key with a left node and right node.
   All nodes in the left subtree contain value strictly
   less than node value,
   All nodes in the right subtree contain value strictly
   greater than node value *)
module BinarySearchTree : Tree = struct
  type 'a t = Node of 'a * 'a t * 'a t | Leaf

  let rec insert v = function
    | Leaf -> Node (v, Leaf, Leaf)
    | Node (v', l, r) when v < v' -> Node (v', insert v l, r)
    | Node (v', l, r) when v > v' -> Node (v', l, insert v r)
    | t -> t (* case where v = v' *)

  let rec remove (v : 'a) (t : 'a t) : 'a t =
    match t with
    | Leaf -> Leaf
    | Node (v', Leaf, Leaf) when v' = v -> Leaf
    | Node (v', Leaf, r) when v' = v -> r
    | Node (v', l, Leaf) when v' = v -> l
    | Node (v', _l, _r) when v' = v -> failwith "todo"
    | Node (v', l, r) ->
        if v < v' then Node (v, remove v' l, r) else Node (v, l, remove v' r)

  let empty = Leaf

  let rec inorder t : 'a list =
    match t with Leaf -> [] | Node (v, l, r) -> inorder l @ [ v ] @ inorder r
end

module RBTree : Tree = struct
  type 'a t = unit

  let insert _ _ = failwith "not implemented"
  let remove _ _ = failwith "not implemented"
  let inorder _ = failwith "not implemented"
  let empty = ()
end
