let test_empty () =
  let open Tree.BinarySearchTree in
  ignore empty

module B = Tree.BinarySearchTree

let () =
  let dot_file = "/tmp/bst_dump" in
  let l = [ 98; 64; 73; 14; 99; 57; 27; 77; 95; 92; 28; 64; 15; 33; 32; 49 ; 22] in
  (* let l = [ 98; 64; 14; 99 ] in *)
  let t = List.fold_left (fun bst x -> B.insert x bst) B.empty l in
  B.dump (dot_file ^ "1.dot") t;
  print_endline @@ "BinarySearchTree dumps in " ^ dot_file;
  print_endline @@ "To visualize it: dot -Tpng " ^ dot_file ^ " | xview -";
  print_newline ();
  let t = B.remove 27 t in
  B.dump (dot_file ^ "2.dot") t;
  Alcotest.run "BinarySearchTree"
    [ ("empty", [ Alcotest.test_case "call empty" `Quick test_empty ]) ]
