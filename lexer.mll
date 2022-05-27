(* file: lexer.mll *)

{
  open Mfcalc
}

let digit = ['0'-'9']
let ident = ['a'-'z' 'A'-'Z']
let ident_num = ['a'-'z' 'A'-'Z' '0'-'9' '_']
rule token = parse
  | [' ' '\t' '\n']	{ token lexbuf }
  | digit+
  | "." digit+
  | digit+ "." digit* as num
		{ NUM (float_of_string num) }
  | '+'		{ PLUS }
  | '-'		{ MINUS }
  | '*'		{ MULTIPLY }
  | '/'		{ DIVIDE }
  | '^'		{ CARET }
  | '<'		{ LT }
  | '>'		{ GT }
  | '|'		{ OR }
  | '&'		{ AND }
  | '('		{ LPAREN }
  | ')'		{ RPAREN }
  | ident ident_num* as word
  		{ VAR word }
  | eof		{ EOF }
