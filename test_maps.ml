(* test_maps.ml *)

module MakeTests (M : Maps_interface.Map) = struct
  let test name f =
    try
      f ();
      Printf.printf "[PASS] %s\n%!" name
    with
    | Failure msg -> Printf.printf "[FAIL] %s: %s\n%!" name msg
    | Assert_failure (file, line, col) ->
        Printf.printf "[FAIL] %s: assertion failed at %s:%d:%d\n%!" name file
          line col
    | e ->
        Printf.printf "[FAIL] %s: unexpected exception %s\n%!" name
          (Printexc.to_string e)

  (* Define tests *)
  let tests =
    [
      ("empty bindings", fun () -> ignore (M.bindings M.empty));
      ( "insert and find",
        fun () ->
          let m = M.insert "a" 1 M.empty in
          assert (M.find "a" m = Some 1) );
      ( "insert overwrite",
        fun () ->
          let m = M.insert "a" 1 M.empty in
          let m = M.insert "a" 42 m in
          assert (M.find "a" m = Some 42) );
      ( "remove",
        fun () ->
          let m = M.insert "a" 1 M.empty in
          let m = M.remove "a" m in
          assert (M.find "a" m = None) );
      ( "of_list",
        fun () ->
          let m = M.of_list [ ("x", 10); ("y", 20) ] in
          assert (M.find "x" m = Some 10);
          assert (M.find "y" m = Some 20) );
      ( "of_list duplicate raises",
        fun () ->
          let raised =
            try
              let _ = M.of_list [ ("x", 1); ("x", 2) ] in
              false
            with Failure _ -> true
          in
          assert raised );
    ]

  (* Run tests *)
  let run () = List.iter (fun (name, f) -> test name f) tests
end

module ListMapTests = MakeTests (Impl_maps_list.ListMap)
module ArrayMapTests = MakeTests (Impl_maps_array.ArrayMap)

let () =
  Printf.printf "\nTesting ListMap\n";
  ListMapTests.run ();

  Printf.printf "\nTesting ArrayMap\n";
  ArrayMapTests.run ()
