--import mathlib.tactic.basic
--import mathlib.tactic.cases
--import mathlib.init.data.nat.basic
import tactic.induction
import data.set.basic
import logic.equiv.basic
import data.nat

#eval 123 -- and more

#eval lean.version

lemma min_add_add (l m n : ℕ) :
min (m + l) (n + l) = min m n + l :=
begin
  cases' classical.em (m ≤ n),
  case inl {
    simp [min, h] },
  case inr {
    simp [min, h] }
end