(* https://cs3110.github.io/textbook/chapters/ds/rb.html *)
(* https://courses.cs.cornell.edu/cs3110/2021sp/textbook/eff/bst.html *)

module type Tree = sig
  type elt
  type t

  val empty : t
  val insert : elt -> t -> t
  val remove : elt -> t -> t
  val inorder : t -> elt list
  val dump : string -> t -> unit
  val find_min : t -> elt option
end

(* For simplicity also add to_string here instead of creating
   a "Show" interface *)
module type Ordered = sig
  type t

  val compare : t -> t -> int
  val to_string : t -> string
end

(* A node is a key with a left node and right node.
   All nodes in the left subtree contain value strictly
   less than node value,
   All nodes in the right subtree contain value strictly
   greater than node value *)
module BinarySearchTree (Ord : Ordered) : Tree with type elt = Ord.t = struct
  type elt = Ord.t
  type t = Node of elt * t * t | Leaf

  let empty = Leaf

  let rec insert v = function
    | Leaf -> Node (v, Leaf, Leaf)
    | Node (v', l, r) as t ->
        let c = Ord.compare v v' in
        if c < 0 then Node (v', insert v l, r)
        else if c > 0 then Node (v', l, insert v r)
        else t (* case where v = v' *)

  (* [find_min t] returns the minimal value in the tree *)
  let rec find_min (t : t) : 'a option =
    match t with
    | Leaf -> None
    | Node (v, Leaf, _) -> Some v
    | Node (_, l, _) -> find_min l

  let rec remove (v : elt) (t : t) : t =
    match t with
    | Leaf -> Leaf
    | Node (v', l, r) -> (
        let c = Ord.compare v v' in
        if c < 0 then Node (v', remove v l, r)
        else if c > 0 then Node (v', l, remove v r)
        else (* We found the node to remove *)
          match (l, r) with
          | Leaf, Leaf -> Leaf
          | Leaf, _ -> r
          | _, Leaf -> l
          | _ -> (
              match find_min r with
              | None -> failwith "unreachable"
              | Some m -> Node (m, l, remove m r)))

  (* TODO: use a more efficient tail recursive inorder.
     This naive implementation is O(n^2) ... ouch
   *)
  let rec inorder t : 'a list =
    match t with Leaf -> [] | Node (v, l, r) -> inorder l @ [ v ] @ inorder r

  let dump fname bst =
    let oc = Out_channel.open_text fname in
    Out_channel.output_string oc "strict graph {\n";

    let rec aux = function
      | Leaf -> ()
      | Node (v, l, r) ->
          (match l with
          | Node (v', _, _) ->
              let s =
                Printf.sprintf "%s -- %s\n" (Ord.to_string v) (Ord.to_string v')
              in
              Out_channel.output_string oc s
          | Leaf ->
              let s =
                Printf.sprintf "%s -- l_%s\n" (Ord.to_string v)
                  (Ord.to_string v)
              in
              Out_channel.output_string oc s);

          (match r with
          | Node (v', _, _) ->
              let s =
                Printf.sprintf "%s -- %s\n" (Ord.to_string v) (Ord.to_string v')
              in
              Out_channel.output_string oc s
          | Leaf ->
              let s =
                Printf.sprintf "%s -- r_%s\n" (Ord.to_string v)
                  (Ord.to_string v)
              in
              Out_channel.output_string oc s);

          aux l;
          aux r
    in
    aux bst;
    Out_channel.output_string oc "}";
    Out_channel.close oc
end

module RBTree (Ord : Ordered) : Tree = struct
  type elt = Ord.t
  type t = unit

  let empty = ()
  let insert _ _ = failwith "not implemented"
  let remove _ _ = failwith "not implemented"
  let inorder _ = failwith "not implemented"
  let dump _ = failwith "not implemented"
  let find_min _ = failwith "not implemented"
end
