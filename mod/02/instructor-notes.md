# Responsible nuclear AI

PDF-only revision; editable LaTeX included. Sources checked September 5, 2026.

## 1. Responsible nuclear AI

Revised instructional draft. Public and synthetic classroom inputs only. See source notes for checked documentation and distinguish provided code from measured transport results.

- curriculum: User-supplied PHANES curriculum: mod/01 through mod/08/README.md.
- colors: https://umac.utexas.edu/brand-center/colors/

## 2. Start with the actual transfer, not the product label

This module teaches concrete screening and documentation. It does not issue a legal determination. Classroom architecture decisions below are proposed controls, not a declaration of UT approval.

- utexport: https://research.utexas.edu/resources/research-security/export-control

## 3. Three federal routes are not interchangeable

Jurisdiction and exclusions must be assessed from facts. An open-source code license is a separate question from handling a customer’s nonpublic input deck.

- 810scope: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.2
- 110: https://www.nrc.gov/reading-rm/doc-collections/cfr/part110/index
- earrelease: https://www.ecfr.gov/current/title-15/subtitle-B/chapter-VII/subchapter-C/part-734/section-734.13

## 4. Part 810 scope includes reactor-development technology

Paraphrase of scope and definitions, not a conclusion that every nuclear calculation is controlled. Ask the reviewer to identify the activity, technology, recipients, exclusions and authorization path.

- 810scope: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.2
- 810definitions: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.3

## 5. Read the rule in a useful order

Use the section URLs in the sources appendix. This table is a navigation aid, not a substitute for evaluating the rule’s full conditions.

- 810scope: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.2
- 810definitions: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.3
- 810general: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.6
- 810specific: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.7
- 810reports: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.12
- 810interpret: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.5

## 6. Screening an engineering workflow under Part 810

Walk through the sequential five-step decision process: scope, exclusions, general authorization, reporting, and specific authorization. Emphasize that general authorization under 810.6 is not an exemption from reporting under 810.12, and that public availability requires explicit provenance.

- 810scope: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.2
- 810general: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.6
- 810specific: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.7
- 810reports: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.12

## 7. The public-information exclusion needs provenance

The legal proposition is the exclusion and its defined terms. The inventory and mixed-prompt handling are proposed engineering practices for constructing an answerable review request.

- 810scope: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.2
- 810definitions: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.3

## 8. Fundamental research is a defined condition

Keep the legal summary concise. The practical lesson is to separate a potentially publishable result from preexisting data supplied under restrictions.

- 810definitions: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.3
- earresearch: https://www.ecfr.gov/current/title-15/subtitle-B/chapter-VII/subchapter-C/part-734/section-734.8

## 9. Worked case: public paper plus partner dimensions

Ask students to identify the owner, agreement, access list, endpoint operators and intended output. This is a worked review workflow, not an authorization decision about an actual partner.


## 10. General authorization still has conditions

Do not reproduce a country list that may become stale. Require the reviewer to check the current Appendix and the actual recipient, activity and technology.

- 810general: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.6

## 11. Specific authorization must precede covered activity

Do not turn this slide into a generalized prohibition on using AI. It explains when a concrete proposed activity needs a specific regulatory determination.

- 810specific: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.7

## 12. Authorization and reporting are separate checks

Read the full section for the applicable paragraph and exceptions, including employee reporting. This is not a calendar promise for every scenario. Do not confuse excluded public transfers with generally authorized covered activity.

- 810reports: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.12

## 13. US location is one fact among several

These are diligence questions, not factual claims about any named provider. Document answers and unresolved assumptions separately.


## 14. A domestic disclosure can still require analysis

The exact law differs across frameworks. Avoid universal statements such as all foreign-born persons are foreign persons or US-based access is automatically authorized.

- earrelease: https://www.ecfr.gov/current/title-15/subtitle-B/chapter-VII/subchapter-C/part-734/section-734.13
- 810scope: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.2

## 15. Inventory the bytes an agent workflow produces

Do not assume an embedding or summary is automatically decontrolled or non-sensitive. The course proposes an inventory and review of derived artifacts without claiming one legal classification for all such artifacts.


## 16. Worked map: OpenCode plus a private LLM

Have students draw four destinations and label arrows. The map becomes a controlled project artifact, updated when a plugin, remote tool or endpoint is added.


## 17. Ask providers questions that require evidence

A provider answer is evidence for review, not automatically a legal conclusion. No claims about specific commercial vendors are made here.


## 18. Encryption addresses a defined part of the path

General security mechanisms, not a recommendation for a particular confidential GPU product. Ask students to state which actor each control constrains and which paths it does not cover.


## 19. Deployment options are information-flow controls

This is an option space for review, not a ranking. The classroom architecture uses the facility-hosted path so students can inspect the controls directly; ask which controls each option makes auditable and which only contractual.


## 20. Write a technology-control proposal

This is a proposed engineering control plan for review. Use UT’s actual process and approved templates for real projects rather than representing this table as an institutional policy.

- utexport: https://research.utexas.edu/resources/research-security/export-control

## 21. Worked decision memo: what can be concluded?

Show why a memo with explicit unknowns is more useful than a confident statement that the architecture is compliant. The reviewer needs the contract, data inventory and access facts.


## 22. Know what kind of answer a reviewer can give

Section 810.5 specifies the status of written interpretations by DOE General Counsel unless otherwise authorized in writing. Students should route real questions through the institution.

- 810interpret: https://www.ecfr.gov/current/title-10/chapter-III/part-810/section-810.5
- utexport: https://research.utexas.edu/resources/research-security/export-control

## 23. If a workflow crosses the agreed boundary

This is a suggested incident-documentation pattern, not a replacement for UT procedures or statutory notification requirements. Use a synthetic tabletop exercise.


## 24. Lab: produce a reviewable boundary package

Require section-level references, not just the label Part 810. The exercise remains recognition and routing; no student is asked to authorize a real controlled transfer. The multinational-team case returns the deemed-export question to the team's own access list, not to the endpoint location. A sample package structure is shown in the deck (Sample submission: the boundary package); it models organization and explicit unknowns, not approved routing conclusions.

