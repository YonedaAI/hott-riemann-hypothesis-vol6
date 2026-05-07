import Vol6.FiniteBlaschkePacket
import Vol6.FiniteRankDetector
import Vol6.OffCriticalDefectKernel
import Vol6.RationalDilationExternalization
import Vol6.QuotientOrthogonalityAdmissibility
import Vol6.YonedaBlaschkeDetectorCalculus
import Vol6.RHClassicalNewLanguage

/-!
# Vol6 — root entry point

Re-exports Vol6's discharge of the two payloads of the Vol5 conditional theorem
`RH_classical_of_no_phantom_language_breakthrough`.

Sprint modules:

* `Vol6.FiniteBlaschkePacket`              -- concrete model spaces (paper 01)
* `Vol6.FiniteRankDetector`                -- detector for finite packets (paper 02)
* `Vol6.OffCriticalDefectKernel`           -- target 1 (paper 03)
* `Vol6.RationalDilationExternalization`   -- detector ↔ representable (paper 04)
* `Vol6.QuotientOrthogonalityAdmissibility`-- 2.3 + 2.4 (paper 05)
* `Vol6.YonedaBlaschkeDetectorCalculus`    -- target 2 assembly (paper 06)

Synthesis module `Vol6.RHClassicalNewLanguage` is added in paper 07; it is
imported by `Vol6.lean` only after paper 07 has been written and built.

No module in this project contains `sorry`, `admit`, new `axiom`, or new `opaque`.
-/
