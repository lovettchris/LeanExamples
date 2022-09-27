#eval show IO _ from do
  let var ← IO.mkRef 0
  let tasks ← (List.range 50).mapM fun _ => IO.asTask do
    for _ in [0:50] do
      let f i := dbgSleep 1 (fun _ => i+1)
      var.modify f
  tasks.forM (ofExcept ·.get)
  var.get