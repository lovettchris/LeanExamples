structure Jobs where
   processed : IO.Ref (List Nat)

def asyncProcess (name : Nat) : ReaderT Jobs IO (Task (Except IO.Error Unit)) := do
  let jobs ← read
  IO.asTask do
    IO.sleep 1
    jobs.processed.modify (λ s => name :: s)

def processTasks (args: List Nat) : ReaderT Jobs IO Unit := do
  let jobs ← read
  let tasks ← args.mapM fun s => asyncProcess s |>.run jobs
  for task in tasks do
    ofExcept task.get

def foo (args : List Nat) : IO (List Nat) := do
  let processedRef : IO.Ref (List Nat) ← IO.mkRef []
  let jobs : Jobs := {processed := processedRef}
  processTasks args |>.run jobs
  jobs.processed.get

def main : IO Unit := do
  let max := 10000
  let x ← foo (List.range max)

  let a := x.toArray.qsort (·<·)

  for expected in List.range max do
    let actual := a[expected]!
    if actual ≠ expected then
      IO.println s!"unexpected {actual} instead of {expected}"

  IO.println "ok"

#eval timeit "running: " main