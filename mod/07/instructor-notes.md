# RAG for regulatory review

PDF-only revision; editable LaTeX included. Sources checked September 5, 2026.

## 1. RAG for regulatory review

Introduce the module through the opening engineering question. Audience: undergraduate and graduate nuclear engineering students comfortable with Linux and Python.

- curriculum: User-supplied PHANES curriculum: mod/01 through mod/08/README.md.
- colors: https://umac.utexas.edu/brand-center/colors/

## 2. Retrieval supports the reviewer’s judgment

The application is review support, not an automated licensing determination. Use only a curated public corpus and synthetic application statements.


## 3. The regulatory review pipeline

The pipeline separates offline ingestion from the online review flow. Every document chunk preserves its manifest hash, source span and revision. Candidate retrieval generates citations, but the final regulatory finding remains with the human reviewer.


## 4. Preserve the kind of authority

NRC explains that regulatory guides are not substitutes for regulations and compliance with guides is not required as such. Applicability, licenses and commitments require case-specific review. Avoid merging these document classes into an undifferentiated index.

- rg: https://www.nrc.gov/reading-rm/doc-collections/reg-guides/index
- srp: https://www.nrc.gov/reading-rm/doc-collections/nuregs/staff/sr0800/index

## 5. Create a corpus manifest before indexing

The manifest is the provenance foundation. A web page can change; a stable identifier and retained copy let a reviewer reconstruct the cited version. The course bundle provides the lecture assignment, not a pre-curated complete NRC corpus.


## 6. Chunk by meaning and citation boundaries

Ask students to inspect one section split into arbitrary fixed-size chunks and then into clause-aware chunks. Chunk size is a tunable engineering choice; there is no universal best token count.


## 7. Compare retrieval methods on the same queries

Introduce these as mechanisms students will compare experimentally. A CPU lexical baseline keeps the exercise runnable; embedding extensions must use a local or approved private endpoint, with its own configuration and boundary review.


## 8. A high-scoring passage is the wrong revision

Expected: document identity, revision/date and applicability metadata, with explicit source citation. Retain older versions when needed for historical cases; “latest” is not always the correct revision for the reviewed application. A worked approach is shown in the deck (One worked approach: the superseded passage).


## 9. Build a claim-to-evidence record

This is a classroom review-support schema; do not label the output “compliant” solely because related text was found.


## 10. Make an unresolved finding explicit

Synthetic schema example, not an actual regulatory finding. Not finding a requirement in a small corpus is not evidence that no requirement exists. Store the query and corpus version with this record.


## 11. Keep an evidence span and interpretation separate

Offsets need a documented convention, such as Unicode character offsets in the retained extracted text. The source PDF page remains necessary when extraction is unreliable.


## 12. Check citations independently of fluency

A model-generated citation should be checked against the index and source artifact. Distinguish a valid locator from entailment. Students should inspect the original page when extraction may have damaged tables or symbols.


## 13. Calculate retrieval precision and recall

Answers: precision=3/5=0.60; recall=3/4=0.75. Counts are invented for the exercise. The second question introduces severity: missing a key exception can matter more than retrieving a harmless extra passage. The worked solution is shown on the slide immediately after this frame (Worked solution: precision and recall).


## 14. Compare two retrieval configurations

Micro counts aggregate occurrences across queries. Values are synthetic. Neither metric checks citation entailment, revision correctness, or final-answer quality.


## 15. Evaluate retrieval and answers separately

Define the unit of analysis and ground-truth labels before calculating metrics. Small classroom labels require reviewer agreement and documented ambiguous cases.


## 16. Use adversarial but public test cases

Last case tests prompt-injection resilience using harmless synthetic text. Keep document instructions untrusted and avoid actual external transmissions. Diagnose whether failure arose in extraction, chunking, retrieval, or answer generation.


## 17. Lab: build a small review assistant

Have students start with a few selected NRC documents and synthetic statements. The instructor chooses exact sections and labels before teaching. Existing private LLM access does not automatically provide an embedding model. A sample submission outline is shown in the deck (Sample submission: the review assistant); it models the record structure, and the labels come from the instructor's curated set.


## 18. Exit ticket: when should the assistant stop?

Each condition should produce a clear status and next action. Carry the corpus manifest and review-support schema into the capstone. A model answer is shown in the deck (A complete answer: when to stop); grade on producing a status plus next action per condition, not on matching the model wording.

