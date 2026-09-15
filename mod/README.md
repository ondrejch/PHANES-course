# PHANES modules

Individual curriculum modules. IDs are `mod/NN`, zero padded to two digits, in the
order of the module list in [`../README.md`](../README.md).

For the complete 8-module syllabus (intensive short course, elective seminar, or modular inserts), see [`../SYLLABUS.md`](../SYLLABUS.md).

| ID | Title | Phase | Status |
|----|-------|-------|--------|
| `mod/01` | Modern Agentic Engineering: From GPUs to Agents | I | draft v0 |
| `mod/02` | Responsible Nuclear AI: Information Boundaries, Export Controls, and Commercial APIs | II | draft v0 |
| `mod/03` | Designing Agentic Skills | supporting (delivered with mod/04) | draft v0 |
| `mod/04` | Building an Agentic Framework for Computational Reactor Engineering | I | draft v0 |
| `mod/05` | Verification, Validation, and Assurance of Agentic Engineering Systems | II | draft v0 |
| `mod/06` | Deploying and Operating Inference on HPC-Class Infrastructure | I | draft v0 |
| `mod/07` | RAG for Nuclear Regulatory Review | II | draft v0 |
| `mod/08` | Nuclear Agentic Engineering Capstone | culminating | draft v0 |

Phase I is mod/01, mod/04, mod/06; Phase II is mod/02, mod/05, mod/07. mod/03 is
a supporting module paired with mod/04.

## Per-module layout (as it fills out)

    mod/NN/
    README.md         draft module: objectives, lecture outline, laboratory, assessment
    lectureNN.tex     Beamer deck (16:9); shared theme in mod/phanes-beamer.sty
    lab/              executable lab material: code, data, instructions (added when drafted)
    instructor/       instructor notes, reference solutions, assessment keys

`make slides` builds every deck to `mod/NN/lectureNN.pdf`.

Each module follows the package spec (Educational Architecture):
lecture material and readings, hands-on laboratories with executable example code,
instructor notes, exercises and assessments with reference solutions where
appropriate, and a reproducible software environment.

## Conventions

- Markdown for drafting; TeX or slide artifacts are generated later from these files.
- Module prose follows the house style: no em dashes; commas, colons, semicolons.
- Platform: laboratories target the dedicated TACC-integrated PHANES node; interim
  or sandbox resources are acceptable during development until the node is delivered.
- Public data only in open modules; partner corpora are never assumed.
- Reusable formats (skill spec, provenance block, evidence dossier, benchmark task
  set) are defined once, in the module that introduces them, and reused downstream
  (mod/03 spec is used by mod/04, mod/05, mod/08; mod/05 dossier is used by mod/08).
