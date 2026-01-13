let test_empty () =
  let open Tree.RBTree in
  ignore empty

let () =
  print_endline "Red Black Tree Testsuite";
  Alcotest.run "RBTree"
    [ ("empty", [ Alcotest.test_case "call empty" `Quick test_empty ]) ]
