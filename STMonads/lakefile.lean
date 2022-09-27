import Lake
open Lake DSL

package bug {
  -- add package configuration options here
}

lean_lib Bug {
  -- add library configuration options here
}

@[defaultTarget]
lean_exe bug {
  root := `Main
}
