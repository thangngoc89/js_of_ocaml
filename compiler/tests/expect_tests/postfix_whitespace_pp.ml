module Jsoo = Js_of_ocaml_compiler

let print_compacted source =
  let buffer = Buffer.create (String.length source) in
  let pp = Jsoo.Pretty_print.to_buffer buffer in
  Jsoo.Pretty_print.set_compact pp true;
  let lexed = Jsoo.Parse_js.lexer_from_string source in
  let parsed = Jsoo.Parse_js.parse lexed in
  Jsoo.Js_output.program pp parsed;
  print_endline (Buffer.contents buffer)

let%expect_test "a + +b" =
  print_compacted "a + +b";
  [%expect {|
    a+
    +b; |}]

let%expect_test "a - -b" =
  print_compacted "a - -b";
  [%expect {|
    a-
    -b; |}]