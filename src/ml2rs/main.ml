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

open Ml2rs_lib.Main

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
    let parse_tree = read_file contents in
    let () = visit_parsetree parse_tree in
    ()
 
