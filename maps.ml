module ListMap : Maps_interface.Map = struct
  type ('k, 'v) t = ('k * 'v) list

  let empty = []
  let insert k v m = (k, v) :: List.filter (fun (k', _) -> k' != k) m

  let find k m =
    match List.find_opt (fun (k', _) -> k' = k) m with
    | None -> None
    | Some (_, v) -> Some v

  let remove k m = List.filter (fun (k', _) -> k' <> k) m

  let of_list l =
    List.fold_left
      (fun acc (k, v) ->
        match List.find_opt (fun (k', _) -> k' = k) acc with
        | None -> insert k v acc
        | Some _ -> raise (Failure "List has duplicate keys"))
      empty l

  let bindings l = l
end
