# Shared Linux OpenCode starter

Prerequisites: Bash, Python 3.11+, and the instructor-tested OpenCode CLI installed on the local Linux computer. Use the official OpenCode installation instructions and record `opencode --version`; this package does not silently install or update it. The instructor provides a reachable private HTTPS endpoint, model alias, credential and, when needed, a CA certificate. No student GPU is needed.

From this directory:

```bash
cp .env.example .env
chmod 600 .env
# Edit .env with the instructor-issued values.
./start-opencode.sh --check
./start-opencode.sh
```

The Bash wrapper explicitly sources the trusted `.env` file and exports its values. It does not assume OpenCode automatically loads dotenv files. `PHANES_BASE_URL` must end in `/v1`. Model identity and limits are read from the same file; changing them regenerates the model entry. The generated config references the key through `{env:PHANES_API_KEY}` and does not store the key literal. An optional `PHANES_ENV_FILE` can select a different trusted shell-format file.

The wrapper preserves the current directory. To work on a separate lab repository, enter that directory and invoke this starter using its absolute path. In the TUI, check `/models` and select the `phanes` provider and expected alias. Inspect proposed shell operations before allowing them.

OpenCode merges configuration sources: a project config, preexisting global plugins, MCP tools or managed settings may affect the final behavior. The provider allowlist and permission settings are application controls, not a network firewall or an isolation guarantee. Use a course account/environment with reviewed configuration. Do not copy private data into a lab merely because the model endpoint is private. Keep `.env` out of Git and submissions; examples contain placeholders only.

The endpoint checker reads `/v1/models` and sends one public completion prompt. It validates TLS using the system trust store or `PHANES_CA_FILE`; redirects are rejected. It does not test tool calling, concurrency, GPU memory, model quality, or authorization beyond those two requests. Test tool use through the TUI. No live endpoint was available when this starter was prepared.

## Deterministic calculation demonstration

```bash
python3 heat_balance.py \
  --power-W 100000 --mass-flow-kg-s 2 \
  --cp-J-kg-K 1000 --inlet-K 300 --output run.json
```

Expected temperature rise: 50 K; outlet: 350 K. The file must be new; choose a new filename for another case. An existing result is not overwritten. Invalid inputs return an error and a nonzero status, and do not create a new output file. Never treat an old result as the output of a failed run. The educational tool assumes a steady single stream, constant heat capacity and no heat loss. It does not model reactor feedback, geometry, pressure, phase change or transient safety behavior.

Suggested first TUI task: “Inspect heat_balance.py. Explain its assumptions. Run the 100000 W, 2 kg/s, 1000 J/(kg K), 300 K case to a new JSON file. Verify the result against the equation, and cite the output file in your explanation.”

Module 03 asks students to implement the skill shown on its slides. Module 04 adds a bounded sweep and provenance. Module 05 adds independent tests and report checks. These extensions are assignments, not prebuilt complete lab solutions.

References: [OpenCode config](https://opencode.ai/docs/config/), [providers](https://opencode.ai/docs/providers/), [permissions](https://opencode.ai/docs/permissions/), [skills](https://opencode.ai/docs/skills/). Checked September 5, 2026.
