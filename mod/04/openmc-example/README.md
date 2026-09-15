# OpenMC worked teaching example

This generator builds an idealized UO2 pin, a 17×17 assembly with 25 water sites, or a 3×3 assembly finite core with a water reflector. The water sites have no guide-tube walls; elemental zirconium substitutes for a specified cladding alloy. No depletion, thermal feedback, control rods, soluble boron, or real plant qualification is included. Pin and assembly boundaries are reflective, including axial boundaries; the finite core outer boundary is vacuum. Do not equate their multiplication factors.

Prerequisites: a compatible OpenMC executable and Python package (the source constraints API requires 0.15 or later), NumPy and an explicitly selected cross-section library with thermal scattering and suitable temperatures. These prerequisites are not installed by this package. Configure the trusted `.env.openmc` from the example, then activate your existing solver environment.

## Review and execution

1. Agree on the plan, geometry assumptions and run budget with the agent. Run `python3 -m unittest -v test_spec.py` for specification checks.
2. `source .env.openmc`, then `python3 model.py --mode pin --out runs/pin-smoke` builds XML only. Choose a new directory for every case. Review the generated manifest; missing nuclear data identity must be resolved before a production run.
3. In the case directory run `openmc --plot`. Inspect xy/xz plots and the XML; a plot alone cannot prove non-overlap or neutron balance.
4. After approving the smoke-test budget, run `openmc --geometry-debug --threads 4 > transport.log 2>&1`. Record the command, executable version, start/end times and return code. Retain logs including entropy and lost-particle diagnostics. Geometry debugging itself runs transport.
5. From this example directory, `python3 extract.py runs/pin-smoke` reads exactly the manifest-named statepoint and refuses changed XML or an existing result JSON. Input hashes support traceability but do not prove the solver used them; retain the execution record and prohibit edits during a run.
6. Repeat assembly and core cases. Increase particle/batch budgets only after reviewing source convergence and uncertainty. See lecture 4 for the two-reflector comparison and acceptance gates. Never use the smoke-run settings as an automatic convergence claim.

The tally is a mesh fission reaction rate per source particle. Its normalized spatial fractions are point estimates, not a power calibration; ratio uncertainties are not computed because numerator and denominator are correlated. The extraction record remains `acceptance_pending` until the human reviews convergence, physics and provenance. Retain data release identity and hashes of the actual HDF5 files in your execution record; the manifest hashes only the cross-section index.

## Validation status

The authoring environment checked Python syntax and the pure-Python specification tests. OpenMC and nuclear data were unavailable, so input export, plots, transport, source convergence and result extraction have not been run here. There are no measured reactor results in this package. This is an inspectable classroom starting point, not a validated design.

References: https://docs.openmc.org/en/stable/usersguide/geometry.html ; https://docs.openmc.org/en/stable/usersguide/settings.html ; https://docs.openmc.org/en/stable/pythonapi/generated/openmc.StatePoint.html

Model export API: https://docs.openmc.org/en/stable/pythonapi/generated/openmc.model.Model.html
