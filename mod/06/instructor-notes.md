# Operating local inference

PDF-only revision; editable LaTeX included. Sources checked September 5, 2026.

## 1. Operating local inference

Introduce the module through the opening engineering question. Audience: undergraduate and graduate nuclear engineering students comfortable with Linux and Python.

- curriculum: User-supplied PHANES curriculum: mod/01 through mod/08/README.md.
- colors: https://umac.utexas.edu/brand-center/colors/

## 2. Start with the working NVFP4 launcher

The baseline is selected by the instructor as the working configuration, not benchmarked in this authoring environment. Do not describe the primary launcher as speculation-free. Server deployment remains an instructor/operator task.

- user: User-supplied vllm(1).zip: vllm/vllm-qwen38-nvfp4.sh, README.md, chat_template.jinja; reviewed 2026-09-05.

## 3. A serving budget has several components

Derive the budget as a sum before showing products. Disk checkpoint size is useful evidence but not identical to resident GPU memory. A model fitting at startup does not prove it survives the target workload.


## 4. Estimate weights with an explicit lower bound

This is an idealized packing calculation. It does not promise a supported quantization, architecture-compatible kernels, or a feasible GPU partition. Quantized models retain some tensors and scales at higher precision.


## 5. Weight-only memory grows quickly

Calculated lower bounds in decimal GB, excluding all overhead and cache. The 320B row uses the rounded model-card count; the actual GLM checkpoint is about 321B. The 70B row is a sizing exercise, not a specified model recommendation.

- glm: https://huggingface.co/zai-org/GLM-5.3-Flash
- qmax: https://www.alibabacloud.com/en/press-room/alibaba-unveils-qwen3-8-max?_p_lc=1

## 6. Use model size and workload together

Model facts from provider sources as of 2026-09-05. Active parameters affect work per token; inactive experts still require storage or an explicit offload strategy. Do not infer measured quality or speed from these counts.

- user: User-supplied vllm(1).zip: vllm/vllm-qwen38-nvfp4.sh, README.md, chat_template.jinja; reviewed 2026-09-05.
- glm: https://huggingface.co/zai-org/GLM-5.3-Flash
- qmax: https://www.alibabacloud.com/en/press-room/alibaba-unveils-qwen3-8-max?_p_lc=1

## 7. Why 18B active does not mean an 18B fit

Idealized FP8 lower bound is 320 GB, already much larger than 96 GB. Host placement changes where memory is required and can add transfer/CPU-compute costs; it does not erase the checkpoint. The runtime must explicitly support the selected strategy. The worked solution is shown on the slide immediately after this frame (Worked solution: why 18B active does not fit 96 GB).

- glm: https://huggingface.co/zai-org/GLM-5.3-Flash
- rtx: https://www.nvidia.com/en-us/products/workstations/professional-desktop-gpus/rtx-pro-6000.md

## 8. Consider three hardware classes

Capacity illustrations, not validated deployment recommendations. NVIDIA lists 96 GB for RTX PRO 6000 Blackwell and 2.3 TB total GPU memory for DGX B300. Confirm the exact product edition, usable bytes, power, cooling and topology. Aggregate memory is not automatically one allocatable device.

- rtx: https://www.nvidia.com/en-us/products/workstations/professional-desktop-gpus/rtx-pro-6000.md
- b300: https://www.nvidia.com/en-us/data-center/dgx-b300/

## 9. Size GLM for four 96 GB GPUs

64 GB is only idealized decimal arithmetic. Recipe checkpoint size ≈328.6 decimal GB, leaving ≈55.4 nominal GB before runtime, partitioning and cache. Four-way support, each GPU’s actual usable bytes, and workload profiles decide feasibility; do not promise full 1M context. The worked solution is shown on the slide immediately after this frame (Worked solution: the GLM sizing gap).

- glmrecipe: https://recipes.vllm.ai/zai-org/GLM-5.3-Flash

## 10. Size Qwen Max beyond a workstation

All TB values are decimal. Four-bit lower bound leaves 1.104 TB nominal before overhead, cache, and partition constraints. Establish checkpoint availability, license, supported quantization and a validated serving recipe before purchase or deployment. Provider launch announcement alone does not establish those details.

- qmax: https://www.alibabacloud.com/en/press-room/alibaba-unveils-qwen3-8-max?_p_lc=1
- b300: https://www.nvidia.com/en-us/data-center/dgx-b300/

## 11. Not every served model is a chat model

Introduce embeddings before module 07, where the lab index depends on one. The class LLM endpoint does not provide embeddings by default; an embedding model is a separate serving configuration, budget and contract. Recording the embedding revision with the index is the module 07 manifest requirement.


## 12. Context can dominate the remaining memory

For conventional attention: bytes ≈2×layers×KV_heads×head_dimension×bytes_per_element×live_tokens, before implementation details. Do not apply this unmodified to the hybrid Qwen or GLM architecture. Cache scales differ from weight scales.


## 13. Four sequences are not four full contexts

The uploaded script explicitly distinguishes MAX_NUM_SEQS from a full-context guarantee. Its REQUIRE_FULL_CONTEXT_CAPACITY=false setting permits a smaller pool. Do not teach four concurrent maximum-length requests as a measured capability.

- user: User-supplied vllm(1).zip: vllm/vllm-qwen38-nvfp4.sh, README.md, chat_template.jinja; reviewed 2026-09-05.

## 14. GPU topology affects distributed serving

The cited vLLM distributed page is versioned historical documentation for TP/PP concepts, not a current launch recipe. Current GLM recipe documents expert-parallel options. Choose a model-specific supported topology rather than copying parallel flags blindly.

- parallel: https://docs.vllm.ai/en/v0.5.1/serving/distributed_serving.html
- glmrecipe: https://recipes.vllm.ai/zai-org/GLM-5.3-Flash

## 15. Host offload exchanges capacity for other costs

Treat this as a mechanism comparison, not a promise that every engine can offload every model or quantization. For a CPU-heavy system, NUMA placement and memory channels matter; for GPU transfer, PCIe traffic matters. Benchmark the actual offload implementation.


## 16. Plan the complete serving host

Have students ask the facility operator for constraints before selecting hardware. Keep dollar pricing out of the exercise because it changes rapidly and depends on system integration. Required RAM should be measured from the loading/offload method, not set equal to VRAM by rote.


## 17. Read the primary settings before changing them

The primary launcher uses .venv, CUDA 13-related configuration and custom cache sizing logic. These values document the supplied host setup; they are not universally optimal. Preserve a known-good configuration and record any experimental deviations.

- user: User-supplied vllm(1).zip: vllm/vllm-qwen38-nvfp4.sh, README.md, chat_template.jinja; reviewed 2026-09-05.

## 18. Tool use depends on the serving contract

These are observations from the uploaded launcher, not recommended flags for GLM. A response can be syntactically valid text yet fail to produce a usable tool call. Include an actual tool round trip in the acceptance test.

- user: User-supplied vllm(1).zip: vllm/vllm-qwen38-nvfp4.sh, README.md, chat_template.jinja; reviewed 2026-09-05.

## 19. Keep client and server configuration distinct

The bundle contains a sanitized copy of the primary launch script with environment-driven paths and credentials. The original upload is retained unchanged. Live startup still requires the instructor host and pinned runtime.


## 20. Validate service readiness in stages

Separate readiness from capacity testing. The shared checker supports transport and completion checks; students inspect the TUI trace for the tool stage. Do not use a classroom test to infer formal access-control certification.


## 21. Benchmark metrics answer different questions

Measure TTFT from a streaming client when available. Server periodic throughput is aggregate activity and is not per-user decode speed. Record warm/cold cache, input tokens, generated tokens, concurrency and failed requests.


## 22. Use a controlled benchmark matrix

Use instructor-provided public tasks. Vary one factor at a time initially: model, weight precision, context, concurrency, or speculation. Do not present generated numerical performance estimates as measurements.


## 23. Choose a system for a class workload

No unique answer. Strong responses state latency and correctness targets, handle long requests explicitly, and measure contention. Eight enrolled students need not mean eight simultaneous full-context requests. Consider reserving capacity for long jobs. A model approach (admission rule, benchmark, decision rule) is shown in the deck (One worked approach: sizing for the class workload); it is one acceptable design, not the only one.


## 24. GLM is a separate deployment experiment

The recipe and model card were checked on 2026-09-05. Build guidance is fast-moving; pin the tested build. Do not copy Qwen cache constants or the custom Qwen template into GLM. The recipe includes 1M maximum context, not a promise that the class hardware can serve it.

- glmrecipe: https://recipes.vllm.ai/zai-org/GLM-5.3-Flash
- glm: https://huggingface.co/zai-org/GLM-5.3-Flash

## 25. Quantization is a quality experiment too

Do not assume all four-bit formats are interchangeable. NVFP4 hardware support, checkpoint packaging, calibration and mixed-precision tensors affect both feasibility and quality. Run the same held-out task set for each configuration.


## 26. DFlash2 belongs in an isolated experiment

The supplied DFlash2 script uses a separate environment, Inferact checkpoint and a DFlash draft model. No speedup is claimed here. Compare end-to-end latency for identical tasks; large draft batches can add overhead.

- user: User-supplied vllm(1).zip: vllm/vllm-qwen38-nvfp4.sh, README.md, chat_template.jinja; reviewed 2026-09-05.

## 27. Operate with a rollback path

The archive includes rebuild and log-analysis scripts, but no rebuild is executed during lecture preparation. Ensure request logging matches the project information policy. A log may contain user content as well as performance data.


## 28. Diagnose three different out-of-memory cases

Loading: checkpoint size, precision, per-device placement and runtime overhead. Long prefill: activation/workspace headroom, batch token budget and prompt length. Concurrency: live cache state and admission limits. Avoid one universal “increase memory utilization” remedy. The per-case measurements and remedies are shown in the deck (One worked approach: diagnosing the three OOM cases).


## 29. Record a benchmark row completely

The table is a measurement schema, not fabricated performance data. It makes comparisons between configurations interpretable.


## 30. Calculate throughput without conflating latency

Invented values for metric arithmetic only. Timing definitions and endpoint streaming behavior must be fixed before measuring.


## 31. Lab: weights to a measured endpoint

If students lack host access, instructor operates the server while students perform client tests and sizing analysis. Submit exact configurations, measured tables, failures, and a justified workload recommendation. State untested configurations as untested. A sample submission outline is shown in the deck (Sample submission: the benchmark lab); it models the record structure, and all numbers in a real submission come from the student's own measurements.


## 32. Exit ticket: defend a capacity claim

A good answer names the tested workload and model revision, per-device memory, latency and correctness evidence, and the next invalidating change. Do not let aggregate VRAM or a model advertisement stand in for a capacity report. A model answer is shown in the deck (A complete answer: defending the capacity claim); grade on separating estimates from measurements and naming a concrete rejection criterion.

