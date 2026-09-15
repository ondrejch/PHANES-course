# Agentic software development

PDF-only revision; editable LaTeX included. Sources checked September 5, 2026.

## 1. Agentic software development

Revised instructional draft. Public and synthetic classroom inputs only. See source notes for checked documentation and distinguish provided code from measured transport results.

- curriculum: User-supplied PHANES curriculum: mod/01 through mod/08/README.md.
- colors: https://umac.utexas.edu/brand-center/colors/

## 2. One loop, several clearly bounded roles

These are proposed course roles, not a universal built-in OpenCode team. Several roles may be separate turns of one model; separate processes are useful only when their work and evidence can be bounded.


## 3. The development loop includes feedback

Planner and researcher can exchange evidence before implementation. Test design can begin from the contract before code. Verification failures return to implementation; a changed requirement returns to the user/planner. Documentation follows accepted behavior. This is a proposed process, not an automatic OpenCode scheduling guarantee.


## 4. Define a handoff artifact for every role

A long conversational handoff often hides the important facts. Ask students to make each role produce a compact artifact and reference full evidence by path.


## 5. Start with a task contract

Use this ordinary software task to teach the loop before introducing OpenMC. The user can authorize reversible edits and local tests as a class of work, avoiding per-keystroke approval.


## 6. What the user should ask the planner

This is a sample user prompt to OpenCode, not instructions to the assistant preparing these lectures.


## 7. Research should resolve implementation uncertainty

Example: determine whether the existing JSON contains explicit unit keys or requires a schema upgrade. That changes the implementation and may require a user decision.


## 8. The implementer works inside the accepted scope

An implementer should not silently rewrite tests to make an incorrect implementation pass. Model autonomy is bounded by the task contract and execution permissions.


## 9. The verifier must be able to disagree

A second model repeating the first model’s claims is not independent evidence. Different prompts and isolated context can help, but independent references and tests matter more than role labels.


## 10. Test design comes from requirements

The tests may be drafted in parallel with implementation if file ownership is separated, or before it. Avoid tests that merely reproduce the implementation’s own mistaken assumptions.


## 11. Documentation follows observed behavior

A documentation role may edit docs and examples under its allowed scope. It should not invent benchmark results, deployment success or unexecuted solver outputs.


## 12. The user has four main interaction points

The user should not be required to approve every routine read or already-authorized local test. Conversely, a model should not silently decide a material physical assumption or publish externally.


## 13. A verifier reports a real defect

Compare two possible fixes. Blind relabeling is incorrect. Conversion may be legitimate only if it is part of the interface contract and is independently tested.


## 14. Permissions should follow role responsibilities

Suggested initial classroom policy, not an isolation guarantee. Broaden access only for a concrete role need. Remote solver, network, package installation, secrets and Git publishing are distinct capabilities.


## 15. OpenCode permission syntax is explicit

Excerpt for discussion; the starter keeps credentials as environment references. Do not approve a shell command as harmless merely because the read tool would deny the same file.

- ocpermissions: https://opencode.ai/docs/permissions/
- occonfig: https://opencode.ai/docs/config/

## 16. Define a read-only planning role

Illustrative config excerpt, not an automatically installed agent. A primary role handles the user conversation; subagents are separately configured. Omitted model settings inherit the configured primary model.

- ocagents: https://opencode.ai/docs/agents/

## 17. Allow only the intended delegated roles

Current documentation says later matching task rules win and users can invoke subagents directly. This is why a task allowlist is not a complete access boundary.

- ocagents: https://opencode.ai/docs/agents/

## 18. A permitted command can still have broad effects

These are concrete execution implications, not a request for endless approval. A stable, reviewed test command in a controlled environment can be preauthorized for the task.


## 19. Use Git boundaries for coherent changes

Multiple role names do not prevent conflicting writes. Start sequentially for the course; introduce parallel work only when inputs and file ownership are separable.


## 20. Agent, skill, and tool remain distinct

Reintroduce skills after students can place them inside a concrete agent workflow. A skill can be reused by several roles without granting any new execution permission.


## 21. A skill expresses a repeatable review procedure

Lecture text for students to implement; no skill is installed by the course authoring process. The directory name and YAML name must match. Test both selection and procedural adherence.

- ocskills: https://opencode.ai/docs/skills/

## 22. Bound retries and return an actionable blocker

Use the two-cycle budget from the exporter example. A good blocker asks one consequential question and includes the work already completed.


## 23. OAK maps the bounded loop to named agents

OAK is a published reference implementation of the bounded role loop taught in this module, not a PHANES dependency. Its lead router mirrors the user-owned scope decision: small low-risk work bypasses ceremony, larger work follows the structured flow. Defaults reviewed from the repository README on 2026-09-12 (v1.0.43 generation).

- oak: https://github.com/jcarlosrodicio/opencode-agent-orchestration-kit

## 24. OAK's bounded loops are a concrete safety contract

Contrast with the course two-cycle exporter budget: OAK bounds by iteration count and closes only on independent reviewer approval. Emphasize that bounded autonomy is enforced by contract hashing and durable state, not by prompt discipline. Do not present OAK's software-engineering scope as applicable to reactor calculations; the transferable part is the bounded-loop and evidence pattern.

- oak: https://github.com/jcarlosrodicio/opencode-agent-orchestration-kit

## 25. A useful completion message closes the contract

This completes the software loop. A good completion message reports exact changed behavior, summarizes passing and failing checks, lists limitations, and supplies a runnable command for user acceptance.

## 26. Lab: demonstrate the complete development loop

Students may emulate the roles sequentially in the TUI or configure custom agents. Do not grade based on how many agents run concurrently; grade the quality of handoffs and evidence. A sample submission outline is shown in the deck (Sample submission: the development-loop lab); it models the record structure, not a required defect or permission setup.

## 27. Exit ticket: bounded roles in practice

Use these four questions to confirm that students grasp why roles, budgets, and escalation gates are necessary. A model answer is shown in the deck (A complete answer: bounded roles); grade on recognizing why the verifier must not write fixes, how iteration limits prevent runaway loops, why shell commands bypass file permissions, and when changing assumptions requires human reauthorization. Module 04 applies these roles to a transport physics workflow.

