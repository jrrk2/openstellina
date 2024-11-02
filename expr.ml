open Calc

  let create_hashtable size init =
    let tbl = Hashtbl.create size in
    List.iter (fun (key, data) -> Hashtbl.add tbl key data) init;
    tbl

  let fun_table = create_hashtable 16 [
    ("sin", sin);
    ("cos", cos);
    ("tan", tan);
    ("asin", asin);
    ("acos", acos);
    ("atan", atan);
    ("log", log);
    ("exp", exp);
    ("sqrt", sqrt);
  ]

let rec simplify acclst = function
  | Bool(bool) -> Bool bool
  | Num(float) -> Num float
  | Neg(expr) -> (match simplify acclst expr with Num expr -> Num (-. expr) | expr -> Neg expr)
  | Var(string) -> (if List.mem_assoc string acclst then simplify acclst (List.assoc string acclst) else Var string)
  | Add(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Num float, Num float2 -> Num (float +. float2) | _ -> Add(simplify acclst expr, simplify acclst expr2))
  | Sub(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Num float, Num float2 -> Num (float -. float2) | _ -> Sub(simplify acclst expr, simplify acclst expr2))
  | Mul(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Num float, Num float2 -> Num (float *. float2) | _ -> Mul(simplify acclst expr, simplify acclst expr2))
  | Div(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Num float, Num float2 -> Num (float /. float2) | _ -> Div(simplify acclst expr, simplify acclst expr2))
  | Caret(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Num float, Num float2 -> Num (float ** float2) | _ -> Caret(simplify acclst expr, simplify acclst expr2))
  | Lt(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Num float, Num float2 -> Bool (float < float2) | _ -> Lt(simplify acclst expr, simplify acclst expr2))
  | Gt(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Num float, Num float2 -> Bool (float > float2) | _ -> Gt(simplify acclst expr, simplify acclst expr2))
  | And(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Bool bool, Bool bool2 -> Bool (bool && bool2) | _ -> And(simplify acclst expr, simplify acclst expr2))
  | Or(expr, expr2) -> (match simplify acclst expr, simplify acclst expr2 with Bool bool, Bool bool2 -> Bool (bool || bool2) | _ -> Or(simplify acclst expr, simplify acclst expr2))
  | Func(string, expr2) -> (match Hashtbl.find_opt fun_table string, simplify acclst expr2 with
    | Some exp, Num float -> Num (exp float)
    | _, exp -> Func(string, exp))

let rec dump fd acclst = function
  | Bool(bool) -> Printf.printf "%s" (string_of_bool bool)
  | Num(float) -> Printf.printf "%.2f" float
  | Neg(expr) -> output_string fd "-("; dump fd acclst expr; output_string fd ")"
  | Var(string) -> (if List.mem_assoc string acclst then dump fd acclst (List.assoc string acclst) else output_string fd string)
  | Add(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " + "; dump fd acclst expr2; output_string fd ")"
  | Sub(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " - "; dump fd acclst expr2; output_string fd ")"
  | Mul(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " * "; dump fd acclst expr2; output_string fd ")"
  | Div(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " / "; dump fd acclst expr2; output_string fd ")"
  | Caret(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " ** "; dump fd acclst expr2; output_string fd ")"
  | Lt(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " < "; dump fd acclst expr2; output_string fd ")"
  | Gt(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " > "; dump fd acclst expr2; output_string fd ")"
  | And(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " & "; dump fd acclst expr2; output_string fd ")"
  | Or(expr, expr2) -> output_string fd "("; dump fd acclst expr; output_string fd " | "; dump fd acclst expr2; output_string fd ")"
  | Func(string, expr2) -> (match Hashtbl.find_opt fun_table string, simplify acclst expr2 with
    | Some exp, Num float -> Printf.printf "%f" (exp float)
    | _ -> output_string fd (string^"("); dump fd acclst expr2; output_string fd ")")

let dump fd acclst x = dump fd acclst x; print_endline ""

(* Assumes the parser file is "mfcalc.mly" and the lexer file is "lexer.mll". *)
let expr str =
    let lexbuf = Lexing.from_string str in
    Mfcalc.item Lexer.token lexbuf
