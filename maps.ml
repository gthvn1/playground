(* https://cs3110.github.io/textbook/chapters/ds/hash_tables.html *)
module type Map = sig
  type ('k, 'v) t
  (** [('k, 'v) t] is the type of maps that bind keys of type ['k] to values of
      type ['v]. *)

  val insert : 'k -> 'v -> ('k, 'v) t -> ('k, 'v) t
  (** [insert k v m] is the same map as [m], but with an additional binding from
      [k] to [v]. If [k] was already bound in [m], that binding is replaced by
      the binding to [v] in the new map. *)

  val find : 'k -> ('k, 'v) t -> 'v option
  (** [find k m] is [Some v] if [k] is bound to [v] in [m], and [None] if not.
  *)

  val remove : 'k -> ('k, 'v) t -> ('k, 'v) t
  (** [remove k m] is the same map as [m], but without any binding of [k]. If
      [k] was not bound in [m], then the map is unchanged. *)

  val empty : ('k, 'v) t
  (** [empty] is the empty map. *)

  val of_list : ('k * 'v) list -> ('k, 'v) t
  (** [of_list lst] is a map containing the same bindings as association list
      [lst]. Requires: [lst] does not contain any duplicate keys. *)

  val bindings : ('k, 'v) t -> ('k * 'v) list
  (** [bindings m] is an association list containing the same bindings as [m].
      There are no duplicates in the list. *)
end

(* https://ocaml.org/docs/lists *)
(* https://ocaml.org/manual/5.4/api/List.html *)
module ListMap : Map = struct
  type ('k, 'v) t = ('k * 'v) list

  (* *)
  let insert k v m = (k, v) :: m
  let find k m = List.assoc_opt k m
  let remove k m = List.filter (fun (k', _) -> k <> k') m
  let empty = []
  let of_list l = l
  let bindings m = List.fold_left (fun acc (k, v) -> 
          match List.find_opt (fun (k',_) -> k' = k) acc with
          | None -> insert k v acc
          | Some(_) -> raise (Failure "Duplicated keys")
  ) [] m
end
