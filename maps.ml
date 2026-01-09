module ListMap : Maps_interface.Map = struct
  type ('k, 'v) t = ('k * 'v) list (* placeholder type *)

  let empty = []
  let insert k v m = (k, v) :: List.filter (fun (k', _) -> k' != k) m

  let find k m =
    match List.find_opt (fun (k', _) -> k' = k) m with
    | None -> None
    | Some (_, v) -> Some v

  let remove _ _ = failwith "Maps.remove not implemented"
  let of_list _ = failwith "Maps.of_list not implemented"
  let bindings l = l
end
