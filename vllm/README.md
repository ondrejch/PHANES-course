# Instructor server reference

Primary: `vllm-qwen38-nvfp4.sh`, adapted from the supplied working launcher. It uses MTP with three draft tokens, not DFlash2. Copy `.env.server.example` to `.env.server` and configure paths/credentials before launch. Supply the already tested vLLM/CUDA environment; this package does not install it.

Teaching-copy changes: credentials and TLS paths now come from environment variables; working directory and virtual environment are configurable. The KV validator now waits for and parses the separate maximum-concurrency log line. Model, cache policy, generation settings, context and MTP settings remain those of the uploaded primary launcher. These are host-specific reference settings, not a universal hardware recommendation.

The original attachment was not changed. Shell syntax and the log parsing change were checked; live GPU startup and private endpoint operation were not available in the authoring environment. Version-specific log formats may require adapting the validator.

DFlash2 is discussed only as an optional unstable experiment in module 06. Its launcher is intentionally not the primary teaching entry point. GLM and Qwen Max examples are sizing/deployment exercises and are not asserted to run on this server.

The chat template is reproduced from the instructor-supplied archive. Preserve its original notices and verify redistribution terms before public release of the course.
