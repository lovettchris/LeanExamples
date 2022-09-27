def parForIn [ForIn IO σ α] (xs : σ) (f : α → IO PUnit) : IO PUnit := do
  let mut tasks := #[]
  for x in xs do
    tasks := tasks.push (← IO.asTask (f x))
  tasks.forM (ofExcept ·.get)

syntax "parallel " "for " ident " in " termBeforeDo " do " doSeq : doElem
macro_rules
  | `(doElem| parallel for $x in $xs do $seq) => `(doElem| parForIn $xs fun $x => do $seq)

structure Jobs where
   processed : IO.Ref (List String)

def asyncProcess (name : String) : ReaderT Jobs IO (Task (Except IO.Error Unit)) := do
  let jobs ← read
  IO.asTask do
    IO.sleep 500
    jobs.processed.modify (λ s => name :: s)

def processTasks (args: List String) : ReaderT Jobs IO Unit := do
  let jobs ← read
  let tasks ← args.mapM fun s => asyncProcess s |>.run jobs
  for task in tasks do
    ofExcept task.get

def foo (args : List String) : IO (List String) := do
    let processedRef ← IO.mkRef []
    let jobs : Jobs := {processed := processedRef}
    parallel for name in args do
      IO.sleep 500
      jobs.processed.modify (λ s => name :: s)
    jobs.processed.get

#eval foo ["apple", "banana", "orange"] --["banana", "orange", "apple"]
