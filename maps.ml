module ListMap : Maps_interface.Map = struct
  type ('k, 'v) t = ('k* 'v) list (* placeholder type *)

  let empty = []
  let insert _ _ _ = failwith "Maps.insert not implemented"
  let find _ _ = failwith "Maps.find not implemented"
  let remove _ _ = failwith "Maps.remove not implemented"
  let of_list _ = failwith "Maps.of_list not implemented"
  let bindings _ = failwith "Maps.bindings not implemented"
end
