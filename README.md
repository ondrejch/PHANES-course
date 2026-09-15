# PHANES course lectures

Eight PDF lecture decks with editable Beamer sources and instructor notes. UT Austin burnt orange (#BF5700), white and charcoal; each slide has a title. The modules include topic foundations in module 1, concrete compliance scenarios in module 2, a complete software development agent loop and permissions in module 3, and a worked OpenMC teaching model in module 4. Tables use explicit column widths and ragged-right text. No PowerPoint files are included.

## Syllabus & Curriculum

The curriculum is structured as eight focused modules designed for an intensive short course (summer school or winter break), an elective seminar / special topics course (1--2 credits, course number TBD), or modular course inserts (2--4 weeks). The complete syllabus with learning objectives, modular lecture and laboratory schedules, grading criteria, capstone milestones, and flexible delivery options is provided in [SYLLABUS.md](SYLLABUS.md).

## Modules
1. Introduction to agentic engineering
2. Responsible nuclear AI
3. Agentic software development
4. An OpenMC development workflow
5. Verification and assurance
6. Operating local inference
7. RAG for regulatory review
8. Agentic engineering capstone

Use `mod/NN/lectureNN.pdf`; edit its `.tex` and run `make slides` with Beamer, Latin Modern, listings, tabularx and TikZ installed. Source references are clickable in the PDF and included in instructor notes.

Labs target locally run Linux OpenCode TUI with a private inference endpoint set in an env file; see `shared/README.md`. The primary server reference remains `vllm/vllm-qwen38-nvfp4.sh`. DFlash2 is optional and unstable; model comparisons and local hardware sizing are confined to module 6.

Module 4 includes a pin/assembly/finite-core input generator and provenance-aware result extraction under `mod/04/openmc-example/`. These are simplified public teaching models, not validated reactor designs. OpenMC and nuclear data are not installed in the authoring environment: no transport runs, keff values or convergence results are claimed. Numerical comparison values on the slides are explicitly illustrative. Other module labs remain assignments plus the common starter, not complete solutions.

Technical sources were checked September 5, 2026. Confirm installed versions and institutional requirements before teaching. The decks are an instructional draft, not institutional approval. Preserve supplied third-party notices.
