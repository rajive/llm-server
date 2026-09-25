#!/usr/bin/env bash

# Model to serve (HuggingFace handle from vLLM Recipes for your hardware platform)
export MODEL_HANDLE="Qwen/Qwen3.6-35B-A3B"

# Download the model (default: $HOME/.cache/huggingface/)
hf download $MODEL_HANDLE

# Tag for the vLLM image (recommended in the vLLM Recipes), then pull
export VLLM_IMAGE=vllm/vllm-openai:latest
export VLLM_PLATFORM=linux/arm64
docker pull --platform "$VLLM_PLATFORM" "$VLLM_IMAGE"

# Maximum context length (prompt + output). Size to your workload and VRAM.
export MAX_MODEL_LEN=131072

# Recommended starting point for any model that fits in memory on a single node
docker run -d \
  --name vllm-server-${MODEL_HANDLE//\//-} \
  --gpus all \
  --ipc host \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  --entrypoint "" \
  -p 8000:8000 \
  -v "$HOME/.cache/huggingface/hub:/root/.cache/huggingface/hub" \
  "$VLLM_IMAGE" \
  vllm serve "$MODEL_HANDLE" \
  --enable-auto-tool-choice \
  --tool-call-parser qwen3_xml \
  --reasoning-parser qwen3 \
  --max-model-len $MAX_MODEL_LEN \
  --gpu-memory-utilization 0.8
