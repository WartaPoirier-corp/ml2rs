(**************************************************************************)
(*                                                                        *)
(*  Copyright (c) 2021 Ana Gelez <ana@gelez.xyz>                          *)
(*                                                                        *)
(*  All rights reserved.                                                  *)
(*  This file is distributed under the terms of the GNU Lesser General    *)
(*  Public License version 2.1, with the special exception on linking     *)
(*  described in the LICENSE.md file in the root directory.               *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)


(* let () = Ml2rs_lib.Main.main () *)

let help = "ml2rs -i <input> -o <output>"
let input = ref ""
let output = ref ""
let args_spec = [
    ("-i", Arg.Set_string input, "Input file (.ml)");
    ("-o", Arg.Set_string output, "Output file (.rs)")
]

let () =
    let () = Arg.parse args_spec (fun _ -> ()) help in
    let input_file = open_in !input in
    let contents = really_input_string input_file (in_channel_length input_file) in
    let lex = Lexing.from_string contents in
    let parse = Parse.implementation lex in
    let _ = List.map (fun (elt: Parsetree.structure_item) -> match elt.pstr_desc with
        | Parsetree.Pstr_eval _ -> ()
        | Parsetree.Pstr_value (_, bindings) -> List.fold_left (fun (_: unit) (binding: Parsetree.value_binding) -> match binding.pvb_pat.ppat_desc with
            | Parsetree.Ppat_var name -> Printf.printf "found a let binding for %s\n" name.txt
            | _ -> ()
        ) () bindings
        | _ -> failwith "oh no"
    ) parse in
    Printf.printf "%s" contents
    
