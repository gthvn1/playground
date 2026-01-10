module ArrayMap : Maps_interface.Map = struct
  type ('k, 'v) t = unit

  let empty = ()
  let insert _k _v _m = failwith "Array: not implemented"
  let find _k _m = failwith "Array: not implemented"
  let remove _k _m = failwith "Array: not implemented"
  let of_list _l = failwith "Array: not implemented"
  let bindings _l = failwith "Array: not implemented"
end
