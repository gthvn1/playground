(* test_maps.ml *)

module MakeTests (M : Maps_interface.Map) = struct
  let tests =
    let open Alcotest in
    [
      test_case "empty bindings" `Quick (fun () -> ignore (M.bindings M.empty));
      test_case "insert and find" `Quick (fun () ->
          let m = M.insert "a" 1 M.empty in
          check (option int) "find a" (Some 1) (M.find "a" m));
      test_case "insert overwrite" `Quick (fun () ->
          let m = M.insert "a" 1 M.empty in
          let m = M.insert "a" 42 m in
          check (option int) "find a" (Some 42) (M.find "a" m));
      test_case "remove" `Quick (fun () ->
          let m = M.insert "a" 1 M.empty in
          let m = M.remove "a" m in
          check (option int) "find a" None (M.find "a" m));
      test_case "of_list" `Quick (fun () ->
          let m = M.of_list [ ("x", 10); ("y", 20) ] in
          check (option int) "find a" (Some 10) (M.find "x" m);
          check (option int) "find a" (Some 20) (M.find "y" m));
      test_case "of_list duplicate raises" `Quick (fun () ->
          check_raises "duplicate keys raise failure" (Failure "of_list")
            (fun () -> ignore (M.of_list [ ("x", 1); ("x", 2) ])));
    ]
end

module ListMapTests = MakeTests (Impl_maps_list.ListMap)
module ArrayMapTests = MakeTests (Impl_maps_array.ArrayMap)

let () =
  Alcotest.run "Maps"
    [ ("ListMap", ListMapTests.tests); ("ArrayMap", ArrayMapTests.tests) ]
