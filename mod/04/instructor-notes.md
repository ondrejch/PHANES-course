# An OpenMC development workflow

PDF-only revision; editable LaTeX included. Sources checked September 5, 2026.

## 1. An OpenMC development workflow

Revised instructional draft. Public and synthetic classroom inputs only. See source notes for checked documentation and distinguish provided code from measured transport results.

- curriculum: User-supplied PHANES curriculum: mod/01 through mod/08/README.md.
- colors: https://umac.utexas.edu/brand-center/colors/

## 2. The engineering task and its declared limits

The complete model generator and extraction utilities are included under mod/04/openmc-example/. No neutron-transport result was produced during lecture authoring because OpenMC and nuclear data were unavailable. Numerical statistics exercises are explicitly illustrative.


## 3. OpenMC supplies stochastic transport evidence

Unlike the earlier analytical calculator, OpenMC results are stochastic. Use deterministic code for model construction/validation while treating transport outputs statistically.

- omintro: https://docs.openmc.org/en/stable/usersguide/beginners.html

## 4. Assign the OpenMC work to the development roles

Connect each role to a file or result. A geometry plot and a statepoint are stronger handoff evidence than an assurance that the code looks reasonable.


## 5. Start the TUI with an explicit OpenMC request

The project’s existing private inference .env workflow remains unchanged. The OpenMC nuclear data path is local solver configuration, not a model API parameter.


## 6. Freeze the geometric specification

Dimensions are explicit classroom inputs, not a vendor design. The water sites omit guide-tube walls and are an intentional simplification. OpenMC length inputs use cm. The symmetric water pattern is pedagogical, not a claim to reproduce a specific PWR.


## 7. Make the material model explicit

The enrichment argument uses OpenMC’s uranium enrichment convention; the resulting isotopic vector should be inspected. Density and temperature are independent fixed teaching inputs, not a coupled state calculation. Actual available data must support the selected temperatures and scattering law.

- ommat: https://docs.openmc.org/en/stable/usersguide/materials.html

## 8. Construct the fuel and moderator materials

Code excerpt matches the included generator. Record nuclear-data library, isotope/thermal tables, and temperatures. An XML export does not prove those data will load successfully in transport.

- ommat: https://docs.openmc.org/en/stable/usersguide/materials.html

## 9. Use signed regions for the pin

Negative is inside a cylinder; positive is outside. The gap/cladding intersection notation is easy for a generated model to reverse. Validate radii before model construction.

- omgeom: https://docs.openmc.org/en/stable/usersguide/geometry.html

## 10. Check geometry before running any particles

These are exact arithmetic checks of the chosen inputs. They do not establish physical model adequacy. The independent spec tests in the bundle exercise these relationships without needing OpenMC.


## 11. Build the assembly lattice deliberately

Array row direction is not the same as increasing physical y; OpenMC documents the assignment convention. A symmetric pattern hides orientation errors, so test an asymmetric marker in an isolated geometry-check case before generalizing the code.

- omlattice: https://docs.openmc.org/en/stable/pythonapi/generated/openmc.RectLattice.html

## 12. A finite core changes the boundary problem

The root cells partition the outer box into core_region and its complement. Nested lattices can repeat an identical assembly while each occurrence is spatially distinct. The included code contains all root planes and fill operations.

- omgeom: https://docs.openmc.org/en/stable/usersguide/geometry.html

## 13. Inspect each stage with a different question

Use xy and xz slice plots, point-location checks, and geometry-debug transport. Sampling and plots find defects but do not prove all geometry is valid. Do not promote on an attractive picture alone.

- omtrouble: https://docs.openmc.org/en/stable/usersguide/troubleshoot.html

## 14. Separate building, plotting, and transport

OpenMC long flags are documented in its command-line interface. These commands require a working local installation and data. The lecture authoring environment does not contain them.

- omtrouble: https://docs.openmc.org/en/stable/usersguide/troubleshoot.html

## 15. Set source and batch controls explicitly

For large problems the source convergence may require many more inactive generations. Do not infer confidence from the small statepoint produced by a smoke run.

- omsource: https://docs.openmc.org/en/stable/pythonapi/generated/openmc.IndependentSource.html
- omsettings: https://docs.openmc.org/en/stable/usersguide/settings.html

## 16. Plan convergence runs instead of assuming them

These are proposed experiment budgets, not guarantees of convergence. For one generation per batch the higher-statistics example has 4 million active histories. Review source entropy, keff history, uncertainties and workload cost before accepting.

- omsettings: https://docs.openmc.org/en/stable/usersguide/settings.html

## 17. Source convergence precedes tally acceptance

The included generator sets an entropy mesh. Its presence does not automatically diagnose convergence. A reviewer inspects the actual source evolution and repeated-run evidence.

- omsettings: https://docs.openmc.org/en/stable/usersguide/settings.html

## 18. Shannon entropy diagnoses fission source convergence

Explain the mathematical definition of Shannon entropy over the spatial fission source mesh ($H_{\mathrm{src}} = -\sum P_s \log_2 P_s$). In loosely coupled or reflected geometries, $k_{\mathrm{eff}}$ can appear converged early while the spatial source distribution is still migrating. Active tallies accumulated before $H_{\mathrm{src}}$ reaches stationarity introduce spatial bias and invalidate standard deviation estimates.

- omsettings: https://docs.openmc.org/en/stable/usersguide/settings.html

## 19. Request a spatial fission tally

The complete code scales the mesh to each model mode. The tally returns per-source reaction-rate estimates. It is not directly a map in watts.

- omtally: https://docs.openmc.org/en/stable/usersguide/tallies.html

## 20. Normalization is part of the result definition

The example extractor reports raw per-source means and standard deviations plus point-estimate fractions. It does not fabricate uncertainty bars on normalized ratios or interpret a peak fission fraction as a certified power-peaking factor.

- omtally: https://docs.openmc.org/en/stable/usersguide/tallies.html

## 21. Read the exact statepoint into a result record

The extractor verifies the manifest and expected path, reads the numerical estimates, and leaves engineering acceptance pending. A process success and readable statepoint do not establish converged physics.

- omstate: https://docs.openmc.org/en/stable/pythonapi/generated/openmc.StatePoint.html

## 22. Bind each run to its actual inputs

The bundle hashes the cross_sections.xml index and all model inputs; the instructor must also identify/pin the underlying data release because the index hash alone does not hash every HDF5 table.


## 23. Run the reflector comparison as two cases

This is a single-parameter teaching comparison, not a design optimization or a guarantee that the two proposed runs achieve sufficient precision.


## 24. Extend the comparison into a bounded sweep

The two-case comparison is the minimal sweep. A declared grid keeps every run reproducible and separates sampling uncertainty from the parameter trend. Do not treat a sweep as optimization: the values and order are declared before any result is seen.


## 25. Work the comparison before interpreting it

These values are invented solely for arithmetic instruction and are not outputs of the supplied OpenMC model. Delta rho is about 119.38 pcm; first-order sigma is about 31.84 pcm. Sampling uncertainty does not cover model bias or nuclear-data uncertainty.


## 26. Choose the next run from the evidence

The scaling is an approximation under comparable, sufficiently converged sampling conditions. It is not a remedy for incorrect geometry or source bias. No actual runtime estimate is claimed.


## 27. Predeclare checks an agent may not waive

These are project acceptance rules for the example. The numerical thresholds and convergence criteria belong to the reviewed experiment specification, not a free-form agent preference.


## 28. Worked failure: the agent removes thermal scattering

This demonstrates a consequential exception requiring user/operator input, rather than an arbitrary request to approve every command.

- ommat: https://docs.openmc.org/en/stable/usersguide/materials.html

## 29. What the user reviews at each OpenMC gate

These gates apply the module 03 interaction pattern. For a previously approved bounded run set, the agent can execute routine cases without repeatedly reopening the same decision.


## 30. Lab: complete the OpenMC evidence package

The bundle is a worked setup and code starter, not a completed transport study. The instructor provides the CPU solver environment and cross-section data. Full statepoints need not be sent to the LLM; bounded extracted summaries and local evidence paths suffice. A sample package structure is shown in the deck (Sample submission: the OpenMC evidence package); it contains no transport results, and all statistics in a real submission come from the student's own statepoints.


## 31. Extend the model only through reviewed changes

Close with the boundary between an instructional transport model and a qualified engineering analysis. No capability of the language model removes the need for validated physics methods.

## 32. Exit ticket: verifying a transport calculation

These four questions test the boundaries of Monte Carlo evidence: spatial source convergence vs scalar eigenvalue, statepoint provenance vs recall, reflective vs finite boundary conditions, and proper handling of nuclear data exceptions. A model answer is shown in the deck (A complete answer: transport verification). Module 05 builds on this to construct formal verification and assurance suites.

