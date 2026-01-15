module IntBST = Tree.BinarySearchTree (struct
  type t = int

  let compare = Int.compare
  let to_string = string_of_int
end)

let test_empty () = ignore IntBST.empty

let () =
  let dot_file = "/tmp/bst_dump" in
  let l =
    [ 98; 64; 73; 14; 99; 57; 25; 77; 95; 92; 28; 64; 26; 15; 33; 32; 49; 22 ]
  in
  let t = IntBST.empty |> IntBST.insert 3 in
  let t = List.fold_left (fun bst (x : int) -> IntBST.insert x bst) t l in
  IntBST.dump (dot_file ^ "1.dot") t;
  print_endline @@ "BinarySearchTree dumps in " ^ dot_file;
  print_endline @@ "To visualize it: dot -Tpng " ^ dot_file ^ " | display";
  print_newline ();
  let t = IntBST.remove 25 t in
  IntBST.dump (dot_file ^ "2.dot") t;
  Alcotest.run "BinarySearchTree"
    [ ("empty", [ Alcotest.test_case "call empty" `Quick test_empty ]) ]
