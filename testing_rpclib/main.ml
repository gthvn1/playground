(* https://github.com/mirage/ocaml-rpc/blob/master/example/example.ml *)

(* First we are declaring a functor that described our API and that will be used
   to generate the client and the server depending of its parameter. *)
module MyAPI (R : Idl.RPC) = struct
  let description =
    Idl.Interface.
      {
        name = "MyAPI";
        namespace = Some "MyAPI";
        description =
          [
            "This is an example showing how to use the IDL part of the";
            "ocaml-rpc library. What goes here is a description of the";
            "interface we're currently describing.";
          ];
        version = (1, 0, 0);
      }

  let implementation = R.implement description

  (* We can define some named parameters *)
  let i1 = Idl.Param.mk ~name:"i1" ~description:[ "Parameter i1" ] Rpc.Types.int

  let s1 =
    Idl.Param.mk ~name:"s1" ~description:[ "Parameter s1" ] Rpc.Types.string

  (* Parameters don't need to have name and description *)
  let b1 = Idl.Param.mk Rpc.Types.bool

  (* For the following methods, we use the default error type for any errors
     the methods may throw *)
  let e1 = Idl.DefaultError.err

  (* `declare` is defined in the RPC module passed in, and can do several
     different things. It is only the following two lines that actually do
     anything in this module - the declarations of parameters above are useful
     only in allowing the two declarations here to be succinct. *)
  (* api is not a function, it described an RPC that takes a (int, string) and 
   returns bool *)
  let api1 =
    R.(declare "api1" [ "Description 1" ] (i1 @-> s1 @-> returning b1 e1))

  (* api2 is not a function, it described an RPC that takes a string and returns
     a bool. *)
  let api2 = R.(declare "api2" [ "Description 2" ] (s1 @-> returning i1 e1))
end

module M = Idl.IdM
module MyIdl = Idl.Make (M)

(* We can generate client and server *)
module Client = MyAPI (MyIdl.GenClient ())
module Server = MyAPI (MyIdl.GenServer ())

let _ =
  let open MyIdl in
  (* Declare the callback: when someone call api1 we pass callback *)
  let serv_api1_callback i s =
    Printf.printf "Received '%d' and '%s': returning '%b'\n" i s true;
    ErrM.return true
  in

  let serv_api2_callback s =
    Printf.printf "Received '%s': returning '%d'\n" s 42;
    ErrM.return 42
  in

  (* and register them *)
  Server.api1 serv_api1_callback;
  Server.api2 serv_api2_callback;

  (* Now that we have all callback we can add them to the implementation
     and we are now ready to use them. *)
  let rpc_fn = server Server.implementation in

  (* To see what is passed under the wood print structure that are exchange *)
  let rpc_verbose rpc =
    let open M in
    Printf.printf "Marshalled RPC call: '%s'\n" (Rpc.string_of_call rpc);
    rpc_fn rpc >>= fun res ->
    Printf.printf "Marshalled RPC type: '%s'\n" (Rpc.string_of_response res)
    |> return
    >>= fun () -> return res
  in

  let open ErrM in
  Client.api1 rpc_verbose 7 "hello" >>= fun b ->
  Printf.printf "Result: %b\n" b;
  Client.api2 rpc_verbose "foo" >>= fun i ->
  Printf.printf "Result: %d\n" i;

  return (Result.Ok ())
