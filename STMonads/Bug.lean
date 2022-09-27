structure Jobs where
   processed : List Nat

def asyncProcess (i : Nat) : StateT Jobs IO (Task (Except IO.Error Unit)) := do
  modify (λ s => { processed := i :: s.processed })
  IO.asTask do
    IO.sleep 1

def processTasks (args: List Nat) : StateT Jobs IO Unit := do
  let tasks ← args.mapM fun s => asyncProcess s
  for task in tasks do
    ofExcept task.get

def foo (args : List Nat) : IO (List Nat) := do
  let jobs : Jobs := {processed := []}
  let (_, s) ← processTasks args |>.run jobs
  return s.processed

def test : IO Unit := do
  let max := 10000
  let x ← foo (List.range max)

  let a := x.toArray.qsort (·<·)

  if a.size ≠ max then
    IO.println s!"Returned wrong length {a.size} instead of {max}"
  else
    for expected in List.range max do
      let actual := a[expected]!
      if actual ≠ expected then
        IO.println s!"unexpected {actual} instead of {expected}"

    IO.println "ok"

--#eval timeit "running: " test