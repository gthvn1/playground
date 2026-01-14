let test_empty () =
  let open Tree.BinarySearchTree in
  ignore empty

module B = Tree.BinarySearchTree

let () =
  let dot_file = "/tmp/test.dot" in
  let l = [ 98; 64; 73; 14; 99; 57; 27; 77; 95; 92; 28; 64; 15; 33; 49 ] in
  let t = List.fold_left (fun bst x -> B.insert x bst) B.empty l in
  B.dump dot_file t;
  print_endline @@ "BinarySearchTree dumps in " ^ dot_file;
  print_endline "To visualize it: dot -Tpng /tmp/test.dot | xview -";
  print_newline ();
  Alcotest.run "BinarySearchTree"
    [ ("empty", [ Alcotest.test_case "call empty" `Quick test_empty ]) ]
