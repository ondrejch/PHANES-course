# Introduction to agentic engineering

PDF-only revision; editable LaTeX included. Sources checked September 5, 2026.

## 1. Introduction to agentic engineering

Revised instructional draft. Public and synthetic classroom inputs only. See source notes for checked documentation and distinguish provided code from measured transport results.

- curriculum: User-supplied PHANES curriculum: mod/01 through mod/08/README.md.
- colors: https://umac.utexas.edu/brand-center/colors/

## 2. Why introduce agents in nuclear engineering?

Begin with a concrete workflow students already recognize. Ask them to list which steps require physics knowledge, which are mechanical, and which require human authority. Module 04 develops the OpenMC example in full.


## 3. AI, language models, and agents are different

Operational definitions for the course, not a claim that these terms have only one use. The adjective agentic describes the system’s behavior and surrounding controls, not a special kind of consciousness.


## 4. What is a large language model?

Anchor the plain-language definition before the math: the model is a text generator whose outputs must be connected to external evidence. Ask students which of the listed strengths they have already used and which limit they have personally hit.


## 5. The agentic stack has named layers

Trace one request through the stack from the student host to the GPU and back. Emphasize that capability and correctness are distributed across layers; module 06 answers the GPU budget question and modules 05 and 07 cover verification and retrieval. For read-ahead, OAK (github.com/jcarlosrodicio/opencode-agent-orchestration-kit) is an open-source implementation of the same layered pattern for software engineering; module 03 maps its roles in detail.

- curriculum: User-supplied PHANES curriculum: mod/01 through mod/08/README.md.
- oak: https://github.com/jcarlosrodicio/opencode-agent-orchestration-kit


## 6. Open weights versus hosted models

This is a comparison of deployment and data-path implications, not a claim that one access mode is always better. The classroom endpoint is the open-weight path; use module 02's evidence questions for any hosted alternative.


## 7. A model generates a conditional sequence

Explain conditional generation before introducing autonomy. The equation is a basic probability factorization; it does not say that every deployed architecture has the same internals.


## 8. Training stages explain behavior, not authority

Use an outdated library API as an example: a model can recall a once-valid pattern while current documentation specifies something else. Evidence retrieval and execution checks address that gap.


## 9. Attention and caches explain context costs

Keep the introduction architecture-neutral. Module 06 covers conventional KV estimates and explains why hybrid Qwen/GLM state needs model-specific profiling.


## 10. What is inside one request?

Answer: 32,768−2,000−9,000−13,000−4,096 = 4,672 tokens before additional framing overhead. The log exceeds this by 3,328. Preserve status, command, case identifier, error span and links to the full local artifact. The worked solution is now shown on the slide immediately after this frame (Worked solution: the token margin and log triage).


## 11. Compare a script, a chat, and an agent

Give all three the same task: generate a CSV from a known solver. Ask where variability enters and how students would establish that the CSV corresponds to a real run.


## 12. The agent loop has observable states

This loop is the foundation for the role-based development workflow in module 03. Count tool attempts and distinguish recoverable process errors from invalid engineering assumptions.


## 13. Locate the computation and the data movement

A local TUI does not keep every byte local. The tool’s selected output can become part of the next private API request. Provider selection is not a network firewall.


## 14. A structured call separates intent from execution

Use the existing heat_balance.py as a first demonstration before the larger OpenMC case. Structured output constrains representation; it does not guarantee physical correctness.


## 15. Inspect a concrete tool contract

The numerical example is calculated, not a measured reactor result. The starter rejects invalid inputs and refuses to overwrite an existing output file.


## 16. Context files have different jobs

These are recommended project conventions. Do not confuse an instruction with evidence that it was followed; the execution record and tests establish that.


## 17. Reasoning, retrieval, and tools solve different problems

Ask students to name one failure in each component. Avoid presenting visible reasoning text as an audit trail equivalent to a tool log.


## 18. Configure the private endpoint explicitly

The example hostname is intentionally not operational. Review the generated config and any existing project/global configuration that may merge with it.

- occonfig: https://opencode.ai/docs/config/
- user: User-supplied vllm(1).zip: vllm/vllm-qwen38-nvfp4.sh, README.md, chat_template.jinja; reviewed 2026-09-05.

## 19. Use the compatible API adapter

The actual complete config also sets model limits and application permissions. Do not require students to reproduce this fragment manually when the supplied generator handles it.

- ocprovider: https://opencode.ai/docs/providers/

## 20. Run the first controlled TUI session

Install the instructor-tested OpenCode release first and record its version. The checker sends one public prompt; it does not establish tool-use reliability or serving capacity.


## 21. Diagnose failures by layer

Do not “fix” all errors by weakening certificate checks or changing model settings. The correct remedy depends on which contract failed.


## 22. What the user contributes during development

Module 03 expands this into a role-by-role development loop. Avoid repeatedly approving already agreed reversible steps; request new decisions only when scope, assumptions, permissions or cost change.


## 23. Improve this engineering request

Example: implement the provided educational pin-cell spec, export XML and a geometry plot, run only an approved smoke budget, retain diagnostics, then request approval before the convergence study. No physical conclusion should be claimed from a smoke run. This rewrite is now shown in the deck as a model answer (One worked approach: improving the engineering request); it is one acceptable rewrite, not the only one.


## 24. Lab deliverable: explain the whole evidence chain

Grade the ability to separate explanation, execution, validation and acceptance. Use the shared deterministic starter so the first lab is not blocked on OpenMC installation. A sample submission outline is shown in the deck (Sample submission: the evidence-chain deliverable) so students can check completeness before submitting.


## 25. Before the next module, answer four questions

These questions lead directly into the concrete Part 810 and information-flow cases in module 02. A model answer is shown in the deck (A complete answer: the four pre-module questions); grade responses on the four structural points (agency, location of computation, context provenance, boundary triggers), not on matching the model wording.

