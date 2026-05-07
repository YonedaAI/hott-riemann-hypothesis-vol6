import Lake
open Lake DSL

package «hott-riemann-hypothesis-vol6» where
  -- Volume VI: discharges the two payloads of Vol5's
  -- `RH_classical_of_no_phantom_language_breakthrough`:
  --   * OffCriticalZeroDefectKernel
  --   * YonedaBlaschkeDetectorCalculus
  -- All proof modules MUST be sorry/admit/axiom/opaque-free.
  -- Imports Vol5 directly so the no-phantom language is reused.

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "master"

require «hott-riemann-hypothesis-vol5» from
  "../../hott-riemann-hypothesis-vol5/lean"

@[default_target]
lean_lib «Vol6» where
  roots := #[`Vol6]
