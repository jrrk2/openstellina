open Lymp

(* change "python3" to the name of your interpreter *)
let interpreter = "python3"
let py = init ~exec:interpreter "."
let toaltaz1 = get_module py "toaltaz1"

let trans =
	let trans = get_int toaltaz1 "toaltaz1 " [Pyfloat 52.245104 ; Pyfloat 0.079528] in
	close py;
        trans

