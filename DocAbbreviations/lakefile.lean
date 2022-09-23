import Lake
open Lake DSL

package abbreviations {
  -- add package configuration options here
}

lean_lib Abbreviations {
  -- add library configuration options here
}

@[defaultTarget]
lean_exe abbreviations {
  root := `Main
}
