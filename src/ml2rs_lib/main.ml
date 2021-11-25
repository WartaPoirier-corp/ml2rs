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


(* If you delete or rename this file, you should add
   'src/ml2rs_lib/main.ml' to the 'skip' field in "drom.toml" *)

let read_file contents =
    let lex = Lexing.from_string contents in
    Parse.implementation lex

let visit_parsetree tree =
    let _ = List.map (fun (elt: Parsetree.structure_item) -> match elt.pstr_desc with
        | Parsetree.Pstr_eval _ -> ()
        | Parsetree.Pstr_value (_, bindings) -> List.fold_left (fun (_: unit) (binding: Parsetree.value_binding) -> match binding.pvb_pat.ppat_desc with
            | Parsetree.Ppat_var name -> Printf.printf "found a let binding for %s\n" name.txt
            | _ -> ()
        ) () bindings
        | _ -> failwith "oh no"
    ) tree in
    ()
