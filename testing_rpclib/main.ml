(* https://github.com/mirage/ocaml-rpc/blob/master/example/example.ml *)
module MyAPI (R : Idl.RPC) = struct
  let description =
    Idl.Interface.
      {
        name = "MyAPI";
        namespace = Some "MyAPI";
        description =
          [
            "This is an example showing how to use the IDL part of the  \
             ocaml-rpc ";
            "library. What goes here is a description of the interface we're";
            "currently describing.";
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
  let api1 =
    R.(declare "api1" [ "Description 1" ] (i1 @-> s1 @-> returning b1 e1))

  let api2 = R.(declare "api2" [ "Description 2" ] (s1 @-> returning i1 e1))
end

let () = print_endline "Hello"
