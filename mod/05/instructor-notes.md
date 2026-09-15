# Verification and assurance

PDF-only revision; editable LaTeX included. Sources checked September 5, 2026.

## 1. Verification and assurance

Introduce the module through the opening engineering question. Audience: undergraduate and graduate nuclear engineering students comfortable with Linux and Python.

- curriculum: User-supplied PHANES curriculum: mod/01 through mod/08/README.md.
- colors: https://umac.utexas.edu/brand-center/colors/

## 2. Make each claim testable

Ask which of these claims a single good demonstration can establish. Emphasize bounded evidence about tested conditions, not universal reliability.


## 3. Locate failures at the right layer

Use module 04 records as the system under test. Several failures may coexist. A schema-valid JSON result does not establish physical correctness or authorized information handling.


## 4. Verification and validation ask different questions

Do not claim this classroom framework constitutes a formal nuclear quality assurance program. The purpose is to practice evidence discipline transferable to governed engineering work.


## 5. Design a test that catches a unit error

Use Q=100000 W, flow=2 kg/s, cp=1000, Tin=300; expected Tout=350 K. The defect gives 300.05 K if 100 is used. Require explicit SI fields or a tested conversion function. Tolerance should be justified for this exact arithmetic, for example absolute 1e-9 K. The worked solution is shown on the slide immediately after this frame (Worked solution: the unit-error test).


## 6. Evaluate repeated agent behavior

A seed does not promise bitwise reproducibility across changes in hardware, batching, libraries, or server configuration. Report exactly what was held fixed. A different model revision, prompt template or tool contract is a new system under test: the old evaluation does not transfer.


## 7. Interpret a small evaluation honestly

These are invented teaching counts, not measurements. Repair the missing-unit handling and add targeted tests, then rerun an appropriately held-out evaluation. Twenty attempts do not establish a universal 90% reliability guarantee. A worked reading of this evaluation is shown in the deck (Worked solution: reading the 90% evaluation).


## 8. Test report fidelity separately

A correct calculator can feed an incorrect report. Have students parse the final result table and compare it mechanically with stored JSON. Review narrative claims independently.


## 9. Use human gates where judgment matters

A human gate should specify who decides, what they inspect, and what outcomes are possible. Avoid a generic approval button with no review criteria.


## 10. Treat hostile document text as data

This is a benign prompt-injection robustness exercise. Do not use real secrets or send external requests during the test. A provider allowlist alone does not restrict shell network access. A concrete test setup and verdict are shown in the deck (One worked approach: the injection test); keep the injected text benign and synthetic.


## 11. Build a compact evidence dossier

Reuse this exact structure in the capstone. The dossier should make it possible to challenge the acceptance decision, not just describe the implementation.


## 12. Decide what a change invalidates

Calculator verification can be retained if its environment and inputs are unchanged. End-to-end orchestration, tool parsing, report fidelity and any changed data flows need new evidence. Do not rerun everything without an impact rationale, or assume nothing changed. A model reuse/rerun split is shown in the deck (One worked approach: what a change invalidates).


## 13. Define an executable acceptance record

Tie the rule to a test or a reviewer checklist. The tiny analytical tolerance is specific to the classroom equation, not a general tolerance for Monte Carlo or engineering codes.


## 14. Use mutation tests to challenge the suite

Three benign controlled code defects for the course. Keep the mutation set separate from final held-out task evaluation. A mutation score alone is not complete assurance. A worked mutant-by-mutant mapping (test that must fail, proving artifact) is shown in the deck (One worked approach: the three mutants).


## 15. Lab: harden an intentionally flawed workflow

Instructor preparation: use four controlled variants of the module 04 workflow; keep the fault key separate from student handouts. Grade detection and engineering consequence, not just the number of tests. A sample submission outline is shown in the deck (Sample submission: the hardening lab); it models the per-fault record structure, not the instructor's fault key.


## 16. Exit ticket: what evidence is still missing?

Use this as the transition to operating the inference service. Infrastructure updates are changes to the system under evaluation, not merely maintenance details. A model answer is shown in the deck (A complete answer: the exit ticket); grade on identifying a claim with matching evidence, an uncovered condition, a concrete abstention trigger, and a change that reopens review.

