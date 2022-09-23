import Abbreviations


def main (args : List String) : IO Unit := do
  if args.length < 2 then
    IO.println "Usage: abbreviations <json_file> <markdown_file>"
    IO.println "Converts given json to formatted markdown"
    return

  let fileName := args[0]!
  let output := args[1]!
  let data ← IO.FS.readFile fileName
  let j := readJSonObject data
  let md := formatMarkdown j
  IO.FS.writeFile output md

#eval main ["abbreviations.json", "abbreviations.md"]
