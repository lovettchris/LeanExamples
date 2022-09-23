import Lean.Data.Json

open Lean (Json)

def readJSonObject (data: String): Json :=
  let e := Json.parse data
  match e with
  | Except.error _ => Json.null
  | Except.ok j => j

def escape (s : String) : String :=
  s.foldl (init := "") fun acc c =>
    match c with
    | '|' => acc ++ "\\|"
    | c => acc ++ toString c

partial def formatMarkdown (j: Json): String :=
  let header := "| Abbreviation | Unicode Characters |\n"
            ++  "|--------------|--------------------|\n"

  match j with
  | .null => "null"
  | .bool b => toString b
  | .num n => toString n
  | .str s => s
  | .arr _ => "Error: unexpected array type"
  | .obj kvs => kvs.fold (fun acc k j => acc ++ "| " ++ (escape k) ++ " | " ++ (formatMarkdown j |> escape) ++ "|\n") header
