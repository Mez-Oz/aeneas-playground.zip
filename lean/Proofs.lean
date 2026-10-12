import Aeneas
import RustDemo
open Aeneas Aeneas.Std Result
-- NOTE: names/signatures depend on your Aeneas version. Open lean/RustDemo.lean,
-- check the generated signature, and adapt. See tests/lean/Tutorial in the Aeneas repo.

namespace rust_demo

/-- max returns something >= both inputs, and never fails. -/
theorem max_spec (a b : U32) :
    ∃ r, max a b = ok r ∧ r.val ≥ a.val ∧ r.val ≥ b.val := by
  unfold max
  split <;> simp_all [Result.ok.injEq] <;> scalar_tac

end rust_demo
