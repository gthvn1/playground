module ArrayMap : Maps_interface.Map = struct
  type ('k, 'v) t = unit

  let empty = ()
  let insert k v m = failwith "Array: not implemented"
  let find k m = failwith "Array: not implemented"
  let remove k m = failwith "Array: not implemented"
  let of_list l = failwith "Array: not implemented"
  let bindings l = failwith "Array: not implemented"
end
