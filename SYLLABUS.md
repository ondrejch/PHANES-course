# Agentic Computing for Nuclear Engineers

**Course Syllabus: 8-Module Intensive Short Course / Elective Seminar**  
**Walker Department of Mechanical Engineering / Nuclear & Radiation Engineering Program**  
**The University of Texas at Austin**  
**Program:** PHANES (Preparing Human--AI Nuclear Engineering Systems)[^phanes]  
**Instructional Infrastructure:** Dedicated TACC-Integrated GPU Inference Node (Horizon / H100 / Blackwell Class)  

[^phanes]: **Phanes** is the name of a primordial deity in Orphic Greek mythology, associated with emergence, light, and creation.

---

## Course Overview

Nuclear engineering workflows increasingly demand the integration of modern computational infrastructure, automation, and artificial intelligence without sacrificing physical rigor, regulatory compliance, or numerical assurance. Developed under the **PHANES** initiative (Preparing Human--AI Nuclear Engineering Systems), **Agentic Computing for Nuclear Engineers** introduces undergraduate and graduate engineers to the theory, architecture, implementation, and verification of autonomous engineering agents.

This curriculum consists of **eight focused modules**, each pairing an interactive lecture deck with a concrete, hands-on computational laboratory. It is intentionally designed not as a standard full-term lecture course (which requires 20+ lecture periods), but as an agile, high-intensity curriculum delivered as:
1. **An intensive summer school or winter break short course** (e.g. 2 weeks, 8 instructional days plus project defense);
2. **An elective seminar or special topics mini-term** (e.g. 1 session per week over 8 weeks, 1--2 credit hours); or
3. **Modular course inserts** (2--4 week units embedded into existing reactor physics, computational methods, or nuclear safety courses).

Unlike generic software engineering courses, this curriculum is built around the fundamental reality of nuclear systems: language models do not perform physics calculations; validated computational tools do. Students learn to architect agentic systems where modern foundation models serve as orchestrators, interface adapters, and analytical interpreters, while deterministic physics solvers (such as OpenMC) execute nuclear computations under strict configuration control.

Students gain hands-on operational experience across the entire engineering stack:
- Interfacing with local, multi-GPU inference engines on high-performance computing (HPC) infrastructure;
- Establishing and verifying information boundaries under U.S. export controls (10 CFR Part 810);
- Structuring bounded, least-privilege agentic loops using specialized software roles (planner, implementer, test writer, verifier);
- Wrapping reactor analysis solvers into automated, reproducible parameter sweeps;
- Developing formal verification, mutation testing, and assurance dossiers;
- Implementing retrieval-augmented generation (RAG) pipelines for nuclear regulatory review; and
- Executing an end-to-end, peer-reviewed engineering capstone.

---

## Pedagogical Principles

The course is governed by six foundational principles established in the PHANES initiative:

1. **Nuclear engineering first:** Every technique connects directly to an authentic nuclear engineering or regulatory workflow. The course does not convert nuclear programs into generic AI programs.
2. **Build, do not merely prompt:** Students write interface adapters, configure model serving, connect computational tools, inspect execution logs, debug failure modes, and operate infrastructure.
3. **Physics remains in physics solvers:** Agentic systems orchestrate, validate, and interpret computational tools. Language models do not substitute guesses for nuclear engineering calculations.
4. **Verification is designed into the architecture:** Independent tests, cryptographic provenance, validation gates, and human escalation thresholds are intrinsic design requirements, not retrospective additions.
5. **Information boundaries are architectural requirements:** Students assess where information moves before selecting an AI service or designing an agentic interface.
6. **Industry-transferable infrastructure skills:** Students operate facility-hosted multi-GPU inference systems, preparing them for institutional and industrial deployments where commercial APIs are impermissible.

---

## Course Metadata & Prerequisites

- **Course Number:** TBD (Special Topics / Elective Seminar / Workshop)
- **Credit Hours:** 1--2 Credit Hours (or non-credit professional certificate for short-course delivery)
- **Format:** 8 Instructional Modules (8 lecture decks, 8 hands-on labs, 8 exit tickets, 1 culminating capstone project)
- **Prerequisites:**
  - Proficiency in Python (functions, object-oriented design, virtual environments, file I/O).
  - Familiarity with Linux command-line environments and basic shell scripting.
  - Undergraduate coursework in reactor physics fundamentals or computational methods.
  - Familiarity with Monte Carlo or deterministic transport concepts is helpful but not strictly required.
- **Computing Environment:**
  - Students access the dedicated TACC-integrated PHANES GPU inference node via private, authenticated endpoints.
  - Laboratories execute in local Linux environments utilizing the OpenCode Terminal User Interface (TUI) and the OpenCode Agent Orchestration Kit (OAK) harness.
  - All credentials, host addresses, and tokens reside in local, uncommitted `.env` configuration files.

---

## Course Learning Objectives (CLOs)

Upon successful completion of this course, students will be able to:

1. **Deconstruct the Modern AI Stack:** Differentiate between hardware accelerators, weight representations, quantization schemes, context windows, inference serving engines, and agentic harnesses.
2. **Enforce Nuclear Export Controls:** Analyze engineering workflows under 10 CFR Part 810, distinguish fundamental research exclusions from controlled assistance, establish public provenance records, and eliminate unauthorized external data egress.
3. **Architect Bounded Agentic Software:** Implement multi-agent collaboration loops using specialized roles (planner, implementer, test writer, verifier), bounded task budgets, least-privilege tool allowlists, and explicit escalation criteria.
4. **Orchestrate Computational Solvers:** Wrap reactor engineering solvers (OpenMC) into automated workflows, validate geometric clearance, evaluate spatial fission source convergence using Shannon entropy ($H_{\mathrm{src}}$), and propagate statistical uncertainties into reactivity differences ($\Delta\rho$).
5. **Construct Verification and Assurance Suites:** Create executable acceptance records, execute mutation tests to evaluate test-suite robustness, verify report-to-data fidelity, and author claim-to-evidence dossiers.
6. **Deploy and Benchmark HPC Inference:** Size GPU VRAM requirements using exact memory arithmetic, configure continuous batching endpoints using vLLM, and diagnose out-of-memory (OOM) failures across prefill, decode, and concurrency phases.
7. **Engineer Regulatory Retrieval Systems:** Ingest, chunk, and index nuclear regulatory documents (NRC 10 CFR, NUREG, Regulatory Guides), separate verbatim evidence spans from model interpretation, evaluate retrieval precision and recall, and defend against adversarial inputs.
8. **Deliver an Assured Engineering Capstone:** Design, harden, document, and defend an end-to-end agentic workflow on a public-data proxy of an industry-relevant problem, surviving an independent peer red-team review.

---

## Course Materials & Textual Resources

No commercial textbook is required. All readings, laboratory exercises, and software starters are provided through the course repository:

- **Lecture Slides & Instructor Guides:** Eight modular Beamer decks (`mod/01/` through `mod/08/`) and corresponding markdown instructor notes.
- **Reference Codes & Starters:**
  - Computational baseline utilities: `shared/heat_balance.py`, `shared/configure.py`, `shared/check_endpoint.py`.
  - OpenMC reactor model generator & extractor: `mod/04/openmc-example/` (`model.py`, `extract.py`, `spec.py`).
  - Serving scripts & templates: `vllm/vllm-qwen38-nvfp4.sh`, `vllm/chat_template.jinja`.
- **Primary Regulatory & Technical References:**
  - 10 CFR Part 810, *Assistance to Foreign Atomic Energy Activities*, U.S. Department of Energy.
  - 15 CFR Parts 730--774, *Export Administration Regulations (EAR)*, U.S. Department of Commerce.
  - NUREG-1537 / NUREG-0800, *Standard Review Plan for the Review of Safety Analysis Reports for Nuclear Power Plants*, U.S. Nuclear Regulatory Commission.
  - OpenMC Documentation and Theory Manual, *openmc.org*.
  - vLLM Architecture & Continuous Batching Documentation, *docs.vllm.ai*.

---

## Delivery Formats & Pacing Options

The 8-module structure enables three primary operational formats:

| Format | Structure | Pace | Intended Audience |
|:-------|:----------|:-----|:------------------|
| **A. Intensive Summer / Winter Short Course** | 2 Weeks (8 Days + Defense) | 1 module per day (morning lecture, afternoon lab) | Graduate students, national laboratory researchers, industry engineers |
| **B. Elective Seminar / Special Topics** | 8--10 Weeks (1--2 Credits) | 1 module per week (lecture + weekly lab assignment) | Upper-division undergraduates, graduate students |
| **C. Modular Course Inserts** | 2--4 Weeks | Targeted 1--3 module sequences embedded in core courses | Nuclear engineering students in established curricula |

### Modular Course Insert Paths (Format C)
- **Computational Reactor Physics Insert (Modules 01, 03, 04):** Automating transport sweeps, geometric checks, and fission source convergence verification.
- **Nuclear Safety & Regulatory Engineering Insert (Modules 02, 07):** Information classification, Part 810 compliance, and citation-backed regulatory review assistants.
- **Nuclear Software Quality Assurance Insert (Modules 03, 05):** Role specialization, mutation testing, and claim-to-evidence dossiers for nuclear engineering codes.
- **HPC Inference & Systems Insert (Modules 01, 06):** GPU memory arithmetic, continuous batching, NVLink scaling, and local vLLM operations.

---

## Grading Scheme & Evaluation Rubric

Credit is awarded for verifiable engineering evidence, test-driven validation, and disciplined technical judgment:

| Evaluation Component | Weight | Primary Deliverable & Assessment Standard |
|:---------------------|:------:|:------------------------------------------|
| **Laboratory Exercises (Modules 01--07)** | 30% | Executable script packages, test passing logs, boundary audit sheets, and benchmark tables. |
| **Capstone Proposal & Boundary Review** | 10% | Narrowed 1-input/1-output workflow specification, Part 810 boundary inventory, and verification plan. |
| **Capstone Build & Intermediate Milestones** | 20% | Integrated agent skills, wrapper scripts, solver orchestration, and initial reproducible smoke tests. |
| **Verification Suite & Assurance Hardening** | 15% | Executable acceptance records, mutation test results (killed mutants), and claim-to-evidence dossier. |
| **Peer Red-Team Audit & Response** | 10% | Cross-team vulnerability discovery report and formal documented closure/mitigation of found issues. |
| **Final Capstone Demonstration & Defense** | 15% | Live clean-environment rerun, provenance trace, limitation defense, and technical handoff package. |

---

## The Eight-Module Curriculum

### Module 01: Modern Agentic Engineering: From GPUs to Agents
- **Pacing:** Short Course Day 1 / Seminar Week 1
- **Lecture Topics:**
  - Foundations of generative AI and machine learning for engineers.
  - Tokenization (e.g. 18-bit vocabularies), context windows, embeddings, weights, and floating-point representations.
  - The agentic hierarchy: user $\leftrightarrow$ TUI application $\leftrightarrow$ agent harness $\leftrightarrow$ model API $\leftrightarrow$ GPU server.
  - Treating foundation models as probabilistic token predictors; the necessity of deterministic execution for numerical engineering calculations.
  - Reference analytical physics: single-phase coolant heat balance ($T_{\mathrm{out}} = T_{\mathrm{in}} + \frac{Q}{\dot{m} c_p}$).
- **Laboratory 1:**
  - Interfacing with local LLMs via chat, raw Python HTTP requests, and the OpenCode CLI.
  - Running `shared/heat_balance.py` as an external tool; comparing model estimation to Python calculation.
- **Exit Ticket:** Differentiating probabilistic text generation from deterministic computation.

---

### Module 02: Responsible Nuclear AI: Information Boundaries, Export Controls, and Commercial APIs
- **Pacing:** Short Course Day 2 / Seminar Week 2
- **Lecture Topics:**
  - U.S. nuclear export-control framework: Atomic Energy Act, 10 CFR Part 810.
  - The sequential five-step Part 810 screening process: scope (§810.2), exclusions (§810.2(c)(2) and §810.3), general authorization (§810.6), 30-day reporting (§810.12), and specific authorization (§810.7).
  - Public availability vs fundamental research; establishing documented provenance for open datasets.
  - Deemed exports, foreign-national access, and institutional review boundaries.
  - Mapping data flows: prompts, context embeddings, provider retention, telemetry, and network egress.
  - Facility-hosted inference (TACC) as a regulatory compliance architecture.
- **Laboratory 2:**
  - Auditing hypothetical nuclear engineering workflows; mapping byte flows and destination endpoints.
  - Drafting an information boundary statement and data manifest for open reactor design data.
- **Exit Ticket:** Screening an engineering assistance task under 10 CFR Part 810.

---

### Module 03: Agentic Software Development & Skill Architecture
- **Pacing:** Short Course Day 3 / Seminar Week 3
- **Lecture Topics:**
  - Role decomposition: Planner, Implementer, Test Writer, and Verifier.
  - Tool permission architectures: least privilege, read allowlists, gated shell execution, and network isolation.
  - Bounded agent loops: the OpenCode Agent Orchestration Kit (OAK) safety contract.
  - Bounded iteration budgets (1--6 tasks, maximum 3 cycles per task); avoiding cycling on persistent failures.
  - Preventing shell escape vulnerabilities; crafting unambiguous handoff and completion contracts.
- **Laboratory 3:**
  - Executing a multi-role development loop in OpenCode.
  - Diagnosing an intentional unit defect (Celsius vs Kelvin); enforcing verifier rejection and developer repair.
- **Capstone Milestone 1 (Assigned):**
  - Project proposal drafting: narrow problem scope to 1 input, 1 output, 1 bounded workflow, and an information boundary.
- **Exit Ticket:** Defending verifier independence and loop iteration budgets.

---

### Module 04: Building an Agentic Framework for Computational Reactor Engineering
- **Pacing:** Short Course Day 4 / Seminar Week 4
- **Lecture Topics:**
  - Philosophy of computational reactor engineering: LLM for orchestration, physics solver for transport.
  - Introduction to OpenMC: Python API, geometry modeling, materials definition, and XML generation.
  - Modeling fuel pins, assemblies, and finite reflected cores; geometric sanity checks and clad-to-clad clearance ($1.26 - 2(0.4750) = 0.3100$~cm).
  - Boundary conditions: infinite reflective lattices vs finite cores with physical leakage.
  - Fission source distribution convergence in Monte Carlo transport.
  - Shannon entropy of the fission source ($H_{\mathrm{src}} = -\sum_{s=1}^S P_s \log_2 P_s$); detecting spatial lag when $k_{\mathrm{eff}}$ appears stationary.
  - Separating inactive settling batches from active tally accumulation.
  - Extracting reaction rates, spatial fission tallies, and flux distributions from HDF5 binary statepoints.
  - Propagating statistical sampling uncertainty: calculating $\sigma(\Delta k) = \sqrt{\sigma_A^2 + \sigma_B^2}$ and reactivity difference $\Delta\rho = \frac{\Delta k}{k_A k_B}$.
  - History scaling: calculating sample expansion factors $(( \sigma_{\mathrm{current}} / \sigma_{\mathrm{target}} )^2)$.
  - Immutable run bundles: hashing inputs, cross-section libraries, and statepoint outputs.
- **Laboratory 4:**
  - Executing a bounded reflector thickness sweep; parsing statepoints with `extract.py`.
  - Authoring an automated verification check that halts when thermal scattering $S(\alpha,\beta)$ libraries are omitted.
- **Capstone Milestone 1 Due / Milestone 2 Assigned:** Project Proposal Review & Baseline Computational Pipeline.
- **Exit Ticket:** Diagnosing source convergence and distinguishing $\Delta k$ from $\Delta\rho$.

---

### Module 05: Verification, Validation, and Assurance of Agentic Engineering Systems
- **Pacing:** Short Course Day 5 / Seminar Week 5
- **Lecture Topics:**
  - Failure modes of engineering agents: hallucinations, unhandled exceptions, unit propagation errors, and stale caches.
  - Executable acceptance records: binding acceptance criteria to runnable test commands.
  - Verifying report fidelity: mechanically asserting that summary reports agree with binary solver outputs.
  - Structuring claim-to-evidence dossiers: linking technical claims to verifiable log artifacts and execution hashes.
  - Testing the test suite: the theory and practice of mutation testing.
  - Injecting synthetic faults (mutants): unit corruption, input bypass, and tolerance relaxation.
  - Measuring mutation score: ensuring every injected defect triggers a test failure.
  - Change-impact analysis: determining which verification runs can be safely reused versus which require re-execution.
  - Defining human escalation gates: conditions requiring operator reauthorization.
- **Laboratory 5:**
  - Injecting controlled mutants into the reactor analysis workflow; hardening the test suite until all mutants are killed.
  - Assembling a complete engineering assurance dossier.
- **Capstone Milestone 2 Due / Milestone 3 Assigned:** Baseline Pipeline Review & Tool Integration.
- **Exit Ticket:** Identifying missing evidence and justifying change-impact reuse.

---

### Module 06: Deploying and Operating Inference on HPC-Class Infrastructure
- **Pacing:** Short Course Day 6 / Seminar Week 6
- **Lecture Topics:**
  - AI computing hardware: GPUs (NVIDIA H100, B300), SXM vs PCIe, NVLink interconnects, high-bandwidth memory (HBM).
  - Exact VRAM arithmetic: calculating weight footprint ($\text{bytes} = \text{params} \times \text{bits} / 8$).
  - Distinguishing decimal gigabytes ($\text{GB} = \text{bytes} / 10^9$) from binary gibibytes ($\text{GiB} = \text{bytes} / 2^{30}$).
  - Quantization methods: FP16, FP8, NVFP4, and AWQ; memory vs precision tradeoffs.
  - Sizing KV caches across context lengths and batch sizes; activation memory headroom.
  - Continuous batching and PagedAttention in modern inference servers.
  - Performance metrics: time-to-first-token (TTFT), inter-token latency (ITL), and aggregate generation throughput (tokens/sec).
  - Concurrency scaling and saturation curves; separating latency percentiles from batch averages.
  - Root-cause diagnosis of out-of-memory (OOM) faults: model load, long prefill, and high concurrency.
- **Laboratory 6:**
  - Calculating memory budgets for Qwen3.8-27B, GLM-5.3-Flash, and frontier models.
  - Benchmarking local vLLM serving on TACC resources (`vllm-qwen38-nvfp4.sh`); recording latency, throughput, and VRAM scaling.
- **Capstone Milestone 3 Due / Milestone 4 Assigned:** Tool Integration Review & Failure Hardening.
- **Exit Ticket:** Diagnosing OOM failure modes and defending hardware capacity sizing.

---

### Module 07: RAG for Nuclear Regulatory Review
- **Pacing:** Short Course Day 7 / Seminar Week 7
- **Lecture Topics:**
  - Regulatory review workflows: U.S. NRC Standard Review Plans (NUREG-0800), Regulatory Guides, and 10 CFR.
  - Document ingestion: PDF extraction challenges, preservation of technical tables, and Unicode character offsets.
  - Document chunking: token-based vs section-based segmentation; metadata tagging (revision, date, regulatory tier).
  - Vector embeddings and dense retrieval; combining semantic search with boolean metadata filters.
  - Strict separation of evidence spans from model interpretation in review records.
  - Structuring regulatory findings: schema-based claims (`claim_id`, `source_id`, `span_start`, `span_end`, `evidence_text`, `interpretation`, `status`).
  - Distinguishing valid locators from logical entailment; automated citation verification against source text.
  - Quantifying retrieval performance: micro precision ($P = \text{relevant retrieved} / \text{total retrieved}$) and recall ($R = \text{relevant retrieved} / \text{total relevant}$).
  - Evaluating against adversarial prompts and indirect injection in untrusted technical documents.
  - Setting escalation conditions: when the review assistant must halt and request human examiner review.
- **Laboratory 7:**
  - Indexing a curated public collection of NRC regulatory guides; constructing a dense vector index with metadata filters.
  - Generating structured review records with verified text citations; evaluating retrieval precision/recall and adversarial edge cases.
- **Capstone Milestone 4 Due / Milestone 5 Assigned:** Failure Test Suite Review & Peer Red-Team Exchange.
- **Exit Ticket:** Setting stopping rules and identifying prompt-injection vulnerabilities in regulatory RAG.

---

### Module 08: Nuclear Agentic Engineering Capstone
- **Pacing:** Short Course Day 8 (plus Defense Day) / Seminar Weeks 8--10
- **Lecture Topics & Studio Activities:**
  - Capstone methodology and engineering lifecycle; milestone tracking from proposal to defense.
  - Establishing public proxies of industry-relevant nuclear workflows.
  - Independent peer red-team audit: teams exchange systems to probe physics limits, loop bounds, boundary violations, and report fidelity.
  - Responding to peer findings: formal closure, regression test additions, and operational scope boundaries.
  - Freezing dependencies: pinned versions, containerization, and clean-environment replication.
  - The four-pillar capstone defense:
    1. *Calculation Defense:* Proving outputs originate from verified solver execution, not model hallucinations.
    2. *Boundary Defense:* Proving regulatory information flows adhere to 10 CFR Part 810.
    3. *Autonomy Defense:* Proving the agent operated within bounded iterations and least-privilege permissions.
    4. *Escalation Defense:* Defining unambiguous conditions that force the workflow to stop and request human review.
- **Laboratory 8 & Final Deliverables:**
  - Executing the peer red-team audit and documenting the response matrix.
  - Demonstrating clean-environment replication from a fresh Linux checkout.
  - Conducting the live oral defense and technical demonstration before the faculty review panel.
- **Exit Ticket:** Defending an agentic engineering workflow against calculation, boundary, autonomy, and escalation challenges.

---

## Course Policies & Academic Conduct

### 1. 10 CFR Part 810 & Information Boundary Compliance
All computational exercises in this course utilize public, unclassified, and synthetic educational models. Students are strictly prohibited from entering proprietary, export-controlled, or confidential nuclear engineering data into any model prompt, agent harness, or external tool. All inference operations must utilize the authorized private TACC-integrated endpoint.

### 2. Academic Integrity & Artificial Intelligence Usage
Because this is a course in constructing and evaluating AI agents, the use of AI systems is integral to the coursework. However, students must adhere to strict engineering disclosure standards:
- All model interactions must be captured through logged sessions or structured execution traces.
- Students may never present model-generated code or text as their own work without explicit attribution and verification evidence.
- Every numerical claim in an assignment must be backed by an inspectable calculation artifact (e.g. JSON record, binary statepoint, or unit test output). Fabricating calculations or presenting hallucinated model outputs constitutes a violation of academic integrity.

### 3. Collaboration & Peer Review
Engineering is a collaborative discipline. In this course, team collaboration is required for laboratory exercises and the capstone project. During the Module 08 Peer Red-Team Review, students are expected to vigorously and rigorously challenge peer systems to discover vulnerabilities; feedback must remain professional, technical, and focused on reproducible engineering evidence.
