#!/usr/bin/env bash
# Qwen3.8-27B NVFP4 with vLLM (MTP)
# Same launcher as vllm-qwen38-fp8.sh; only the checkpoint / weight quant differ.
# KV_CACHE_QUANT=8bit|16bit|auto. KV_POLICY=auto lets vLLM profile the hybrid pool.
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/.env.server" ]]; then
    set -a
    source "$SCRIPT_DIR/.env.server"
    set +a
fi
: "${VLLM_API_KEY:?Set VLLM_API_KEY in .env.server}"
: "${VLLM_TLS_KEY:?Set VLLM_TLS_KEY in .env.server}"
: "${VLLM_TLS_CERT:?Set VLLM_TLS_CERT in .env.server}"
cd "${VLLM_WORKDIR:-$SCRIPT_DIR}"
source "${VLLM_VENV:-$PWD/.venv}/bin/activate"
export CUDNN_FRONTEND_CUDART_LIB_NAME=libcudart.so.13

# ============================================================
# LOGGING
# ============================================================

LOGDIR="${LOGDIR:-$PWD/logs}"
mkdir -p "$LOGDIR"
LOGSTAMP="$(date '+%Y-%m-%dT%H-%M-%S%z')"
LOGFILE="$LOGDIR/vllm-qwen38-nvfp4-${LOGSTAMP}.log"
exec > >(tee -a "$LOGFILE") 2>&1
export VLLM_LOGGING_LEVEL=INFO

echo "Logging to:             $LOGFILE"
echo "Start time:             $(date --iso-8601=seconds)"

export HF_HOME="${HF_HOME:-.hf/}"
export CUDA_VISIBLE_DEVICES="${CUDA_VISIBLE_DEVICES:-0}"

# ============================================================
# USER SETTINGS
# ============================================================

# Scheduler limit. Not a guarantee of N full CONTEXT_LENGTH requests.
MAX_NUM_SEQS=4

# If true, fail unless vLLM reports full-context concurrency >= MAX_NUM_SEQS.
REQUIRE_FULL_CONTEXT_CAPACITY=false

CONTEXT_LENGTH=262144
MAX_NUM_BATCHED_TOKENS=16384

# KV cache storage: 8bit (fp8_e4m3), 16bit (bfloat16), or auto (vLLM default).
KV_CACHE_QUANT=auto

# auto: vLLM profiles KV from GPU_MEMORY_UTILIZATION (preferred).
# explicit: pass --kv-cache-memory-bytes.
KV_POLICY=auto

# KV sizing control in AUTO mode only.
# 0.95 packed KV so a 98k-token prefill OOM'd. 0.88 leaves ~7 GiB slack.
GPU_MEMORY_UTILIZATION=0.92

# MTP draft tokens per step.
NUM_SPECULATIVE_TOKENS=3

# ============================================================
# DERIVED SETTINGS -- normally do not change
# ============================================================

# MTP (no DFlash2) 8bit pool on this architecture:
#   36.80 GiB -> 1,038,324 tokens -> 37.16 KiB/token
# 16bit scaled by the measured DFlash2 16/8 hybrid ratio (88.72/47.36).
# Recalibrate from this launcher's 'GPU KV cache size' line after a start.

if (( MAX_NUM_SEQS < 1 || MAX_NUM_SEQS > 4 )); then
    echo "MAX_NUM_SEQS must be between 1 and 4"
    exit 1
fi

case "$REQUIRE_FULL_CONTEXT_CAPACITY" in
    true|false) ;;
    *)
        echo "REQUIRE_FULL_CONTEXT_CAPACITY must be true or false"
        exit 1
        ;;
esac

case "$KV_POLICY" in
    auto|explicit) ;;
    *)
        echo "KV_POLICY must be auto or explicit"
        exit 1
        ;;
esac

MODEL="unsloth/Qwen3.8-27B-NVFP4"

case "$KV_CACHE_QUANT" in
    8bit|fp8|fp8_e4m3)
        KV_CACHE_DTYPE=fp8_e4m3
        KIB_PER_TOKEN=37.16
        ;;
    16bit|bf16|bfloat16)
        KV_CACHE_DTYPE=bfloat16
        KIB_PER_TOKEN=69.60
        ;;
    auto)
        # Preflight only; vLLM picks the real KV dtype. Use BF16 cost as a
        # conservative estimate until a serve prints measured capacity.
        KV_CACHE_DTYPE=auto
        KIB_PER_TOKEN=69.60
        ;;
    *)
        echo "KV_CACHE_QUANT must be 8bit, 16bit, or auto (got: $KV_CACHE_QUANT)"
        exit 1
        ;;
esac

CUDA_GRAPH_MAX_BS=$((MAX_NUM_SEQS * (1 + NUM_SPECULATIVE_TOKENS)))
mapfile -t CUDA_GRAPH_SIZES < <(seq 1 "$CUDA_GRAPH_MAX_BS")

GPU_ID="${CUDA_VISIBLE_DEVICES%%,*}"
GPU_ID="${GPU_ID:-0}"
GPU_TOTAL_MIB="$(nvidia-smi --id="$GPU_ID" --query-gpu=memory.total --format=csv,noheader,nounits | tr -d '[:space:]')"
if [[ -z "$GPU_TOTAL_MIB" || "$GPU_TOTAL_MIB" -le 0 ]]; then
    echo "Could not read GPU $GPU_ID total memory from nvidia-smi"
    exit 1
fi
GPU_TOTAL_BYTES=$((GPU_TOTAL_MIB * 1024 * 1024))

# NVFP4 weights are lighter than FP8. 27 GiB is a preflight reserve until
# this launcher is profiled; AUTO still lets vLLM measure for real.
NON_KV_BYTES="$(awk 'BEGIN { printf "%.0f", 27 * (1024^3) }')"
MAX_SAFE_KV_BYTES="$(awk -v gpu="$GPU_TOTAL_BYTES" -v nonkv="$NON_KV_BYTES" -v u="$GPU_MEMORY_UTILIZATION" 'BEGIN {
    printf "%.0f", gpu * u - nonkv
}')"

if (( MAX_SAFE_KV_BYTES <= 0 )); then
    echo "Non-KV reservation exceeds GPU_MEMORY_UTILIZATION * GPU size"
    exit 1
fi

BYTES_PER_TOKEN="$(awk -v k="$KIB_PER_TOKEN" 'BEGIN { printf "%.0f", k * 1024 }')"
REQUIRED_KV_BYTES="$(awk -v ctx="$CONTEXT_LENGTH" -v n="$MAX_NUM_SEQS" -v b="$BYTES_PER_TOKEN" 'BEGIN {
    printf "%.0f", ctx * n * b
}')"
EST_AUTO_TOKENS="$(awk -v kv="$MAX_SAFE_KV_BYTES" -v b="$BYTES_PER_TOKEN" 'BEGIN { printf "%.0f", kv / b }')"
EST_AUTO_FULL_X="$(awk -v tok="$EST_AUTO_TOKENS" -v ctx="$CONTEXT_LENGTH" 'BEGIN { printf "%.2f", tok / ctx }')"

if [[ "$REQUIRE_FULL_CONTEXT_CAPACITY" == true && "$KV_POLICY" == explicit ]]; then
    if awk -v req="$REQUIRED_KV_BYTES" -v mx="$MAX_SAFE_KV_BYTES" 'BEGIN { exit !(req > mx) }'; then
        echo "Need $(awk -v b="$REQUIRED_KV_BYTES" 'BEGIN { printf "%.2f", b / (1024^3) }') GiB KV for $MAX_NUM_SEQS full ${CONTEXT_LENGTH}-token contexts, but max safe is $(awk -v b="$MAX_SAFE_KV_BYTES" 'BEGIN { printf "%.2f", b / (1024^3) }') GiB"
        echo "Lower MAX_NUM_SEQS, switch KV_CACHE_QUANT to 8bit, or set REQUIRE_FULL_CONTEXT_CAPACITY=false"
        exit 1
    fi
    KV_CACHE_BYTES=$REQUIRED_KV_BYTES
elif [[ "$KV_POLICY" == explicit ]]; then
    KV_CACHE_BYTES=$MAX_SAFE_KV_BYTES
else
    KV_CACHE_BYTES=""
fi

GPU_TOTAL_GIB="$(awk -v b="$GPU_TOTAL_BYTES" 'BEGIN { printf "%.2f", b / (1024^3) }')"
NON_KV_GIB="$(awk -v b="$NON_KV_BYTES" 'BEGIN { printf "%.2f", b / (1024^3) }')"
MAX_SAFE_KV_GIB="$(awk -v b="$MAX_SAFE_KV_BYTES" 'BEGIN { printf "%.2f", b / (1024^3) }')"
REQUIRED_KV_GIB="$(awk -v b="$REQUIRED_KV_BYTES" 'BEGIN { printf "%.2f", b / (1024^3) }')"
GIB_PER_FULL_CTX="$(awk -v k="$KIB_PER_TOKEN" -v ctx="$CONTEXT_LENGTH" 'BEGIN {
    printf "%.2f", k * ctx / (1024 * 1024)
}')"

echo "============================================================"
echo "Qwen3.8-27B NVFP4 vLLM configuration"
echo "============================================================"
echo "Model:                  $MODEL"
echo "max-num-seqs:           $MAX_NUM_SEQS  (scheduler limit, not a full-context guarantee)"
echo "Require full ${CONTEXT_LENGTH} x N: $REQUIRE_FULL_CONTEXT_CAPACITY"
echo "Context/request:        $CONTEXT_LENGTH"
echo "KV cache quant:         $KV_CACHE_QUANT ($KV_CACHE_DTYPE, ${KIB_PER_TOKEN} KiB/token estimate)"
echo "GiB per full context:   ${GIB_PER_FULL_CTX} GiB (preflight estimate)"
if [[ "$KV_POLICY" == auto ]]; then
    echo "KV policy:              AUTO (vLLM profiles from gpu_memory_utilization=${GPU_MEMORY_UTILIZATION})"
    echo "Pre-start KV estimate:  ~${MAX_SAFE_KV_GIB} GiB / ~${EST_AUTO_FULL_X}x full ${CONTEXT_LENGTH}  (informational only)"
else
    KV_CACHE_GIB="$(awk -v b="$KV_CACHE_BYTES" 'BEGIN { printf "%.2f", b / (1024^3) }')"
    echo "KV policy:              EXPLICIT"
    echo "Requested KV cache:     ${KV_CACHE_GIB} GiB (${KV_CACHE_BYTES} bytes)"
    echo "gpu_memory_utilization: $GPU_MEMORY_UTILIZATION (ignored for KV sizing when explicit bytes are set)"
fi
echo "KV needed for N full:   ${REQUIRED_KV_GIB} GiB ($MAX_NUM_SEQS x ${CONTEXT_LENGTH})"
echo "Max safe KV at util:    ${MAX_SAFE_KV_GIB} GiB"
echo "Non-KV reserve:         ${NON_KV_GIB} GiB (NVFP4 weights+runtime, preflight only)"
echo "GPU total:              ${GPU_TOTAL_GIB} GiB"
echo "Batched tokens/step:    $MAX_NUM_BATCHED_TOKENS"
echo "CUDA graph max bs:      $CUDA_GRAPH_MAX_BS"
echo "CUDA graph sizes:       ${CUDA_GRAPH_SIZES[*]}"
echo "Speculative tokens:     $NUM_SPECULATIVE_TOKENS (MTP)"
echo "Prefix cache:           align / mamba block 8"
echo "============================================================"

validate_vllm_kv_capacity() {
    local pid=$1
    local timeout_s=900
    local t=0
    local cap_line=""
    local conc_line=""

    while (( t < timeout_s )); do
        if ! kill -0 "$pid" 2>/dev/null; then
            echo "vLLM exited before reporting KV cache capacity"
            return 1
        fi
        cap_line="$(grep -E 'GPU KV cache size: [0-9,]+ tokens' "$LOGFILE" | tail -n 1 || true)"
        conc_line="$(grep -E 'Maximum concurrency for .* request:' "$LOGFILE" | tail -n 1 || true)"
        if [[ -n "$cap_line" && -n "$conc_line" ]]; then
            break
        fi
        sleep 1
        t=$((t + 1))
    done

    if [[ -z "$cap_line" || -z "$conc_line" ]]; then
        echo "Timed out waiting for vLLM KV cache capacity line"
        return 1
    fi

    local tokens conc
    tokens="$(sed -n 's/.*GPU KV cache size: \([0-9,]*\) tokens.*/\1/p' <<<"$cap_line" | tr -d ',')"
    conc="$(sed -n 's/.*Maximum concurrency for .* request: \([0-9.]*\)x.*/\1/p' <<<"$conc_line")"
    local avail
    avail="$(grep -E 'Available KV cache memory:' "$LOGFILE" | tail -n 1 || true)"

    echo "============================================================"
    echo "vLLM measured hybrid KV capacity"
    echo "============================================================"
    [[ -n "$avail" ]] && echo "$avail"
    echo "$cap_line"
    echo "Parsed KV tokens:       $tokens"
    echo "Parsed full-context x:  ${conc}x  (at ${CONTEXT_LENGTH} tokens/request)"
    echo "max-num-seqs:           $MAX_NUM_SEQS"
    if awk -v r="$conc" -v n="$MAX_NUM_SEQS" 'BEGIN { exit !(r + 0 >= n) }'; then
        echo "RESULT: OK -- measured full-context capacity ${conc}x >= max-num-seqs $MAX_NUM_SEQS"
    elif [[ "$REQUIRE_FULL_CONTEXT_CAPACITY" == true ]]; then
        echo "requested guaranteed full contexts: ${MAX_NUM_SEQS}.00"
        echo "vLLM reported maximum concurrency: ${conc}"
        echo "RESULT: FAIL -- KV pool is undersized"
        return 1
    else
        echo "RESULT: OK for up to $MAX_NUM_SEQS active sequences, but NOT guaranteed for $MAX_NUM_SEQS × ${CONTEXT_LENGTH} live contexts"
    fi
    echo "============================================================"
    return 0
}

VLLM_ARGS=(
    serve "$MODEL"
    --served-model-name "qwen3.8-27b-nvfp4"
    --dtype auto
    --gpu-memory-utilization "$GPU_MEMORY_UTILIZATION"
    --kv-cache-dtype "$KV_CACHE_DTYPE"
    --max-model-len "$CONTEXT_LENGTH"
    --max-num-seqs "$MAX_NUM_SEQS"
    --max-num-batched-tokens "$MAX_NUM_BATCHED_TOKENS"
    --enable-chunked-prefill
    --async-scheduling
    --enable-prefix-caching
    --mamba-cache-mode align
    --mamba-block-size 8
    --max-cudagraph-capture-size "$CUDA_GRAPH_MAX_BS"
    --cudagraph-capture-sizes "${CUDA_GRAPH_SIZES[@]}"
    --speculative-config "{\"method\":\"mtp\",\"num_speculative_tokens\":${NUM_SPECULATIVE_TOKENS}}"
    --chat-template "$PWD/chat_template.jinja"
    --reasoning-parser qwen3
    --enable-auto-tool-choice
    --tool-call-parser qwen3_coder
    --default-chat-template-kwargs '{"enable_thinking":true,"preserve_thinking":true}'
    --generation-config vllm
    --override-generation-config '{"temperature":1.0,"top_p":0.95,"top_k":20,"min_p":0.0}'
    --seed 3407
    --ssl-keyfile "$VLLM_TLS_KEY"
    --ssl-certfile "$VLLM_TLS_CERT"
    --api-key "$VLLM_API_KEY"
    --host 0.0.0.0
    --port 41883
)

if [[ "$KV_POLICY" == explicit ]]; then
    VLLM_ARGS+=(--kv-cache-memory-bytes "$KV_CACHE_BYTES")
fi

vllm "${VLLM_ARGS[@]}" &
VLLM_PID=$!
trap 'kill "$VLLM_PID" 2>/dev/null || true; wait "$VLLM_PID" 2>/dev/null || true' INT TERM

if ! validate_vllm_kv_capacity "$VLLM_PID"; then
    kill "$VLLM_PID" 2>/dev/null || true
    wait "$VLLM_PID" 2>/dev/null || true
    exit 1
fi

wait "$VLLM_PID"
