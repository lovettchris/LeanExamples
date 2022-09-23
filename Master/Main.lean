
#eval Lean.versionString
def main (args: List String): IO Unit :=
  let s := ", ".intercalate args
  IO.println s!"Hello, world: {s}"

def _foo : List String :=
   ["apple", "orange"]

#eval main _f