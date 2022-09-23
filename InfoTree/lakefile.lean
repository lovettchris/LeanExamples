import Lake
open Lake DSL

package infoTree {
  -- add package configuration options here
}

lean_lib InfoTree {
  -- add library configuration options here
}

@[defaultTarget]
lean_exe infoTree {
  root := `Main
}
