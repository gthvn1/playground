(* test_maps.ml *)

module MakeTests (M : Maps_interface.Map) = struct
  let run test_name =
    let open Alcotest in
    run test_name
      [
        ( "Maps",
          [
            test_case "empty bindings" `Quick (fun () ->
                ignore (M.bindings M.empty));
            test_case "insert and find" `Quick (fun () ->
                let m = M.insert "a" 1 M.empty in
                assert (M.find "a" m = Some 1));
            test_case "insert overwrite" `Quick (fun () ->
                let m = M.insert "a" 1 M.empty in
                let m = M.insert "a" 42 m in
                assert (M.find "a" m = Some 42));
            test_case "remove" `Quick (fun () ->
                let m = M.insert "a" 1 M.empty in
                let m = M.remove "a" m in
                assert (M.find "a" m = None));
            test_case "of_list" `Quick (fun () ->
                let m = M.of_list [ ("x", 10); ("y", 20) ] in
                assert (M.find "x" m = Some 10);
                assert (M.find "y" m = Some 20));
            test_case "of_list duplicate raises" `Quick (fun () ->
                let raised =
                  try
                    let _ = M.of_list [ ("x", 1); ("x", 2) ] in
                    false
                  with Failure _ -> true
                in
                assert raised);
          ] );
      ]
end

module ListMapTests = MakeTests (Impl_maps_list.ListMap)
module ArrayMapTests = MakeTests (Impl_maps_array.ArrayMap)

let () =
  ListMapTests.run "ListMap";
  ArrayMapTests.run "ArrayMap"
