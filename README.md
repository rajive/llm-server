# llm-server

Serve a local LLM from a single on-prem NVIDIA DGX Spark, exposing an OpenAI-compatible API to client applications.

## Architecture

![On-prem LLM server architecture](assets/on-prem-llm-server.svg)

The model runs in a `vllm/vllm-openai:latest` container (linux/arm64) on the DGX Spark host's GB10 GPU. The container mounts the Hugging Face cache for the model weights and is reached by clients over HTTP on port 8000.

Diagram source: [assets/on-prem-llm-server.drawio](assets/on-prem-llm-server.drawio)

## Quick start

Choose a launch file for the model you want to serve:

```sh
./nvidia-dgx-spark/serve-qwen3.6-35b-a3b.sh
```

This downloads `Qwen/Qwen3.6-35B-A3B`, pulls the vLLM image, and starts a server with a 131,072-token context limit. The script for `nvidia/Qwen3.6-27B-NVFP4` is [serve-qwen3.6-27b-nvfp4.sh](nvidia-dgx-spark/serve-qwen3.6-27b-nvfp4.sh). Both scripts listen on port 8000 and expect `hf`, Docker, and the NVIDIA Container Toolkit to be available on the DGX Spark host.

The [Gemma 4 31B NVFP4 recipe](nvidia-dgx-spark/gemma-4-31b-it-nvfp4-vllm.yaml) is a recipe definition, not a shell launcher. Its runtime and requirements are described in the YAML.

## Contents

- [nvidia-dgx-spark/serve-qwen3.6-35b-a3b.sh](nvidia-dgx-spark/serve-qwen3.6-35b-a3b.sh) — launch Qwen3.6-35B-A3B with vLLM
- [nvidia-dgx-spark/serve-qwen3.6-27b-nvfp4.sh](nvidia-dgx-spark/serve-qwen3.6-27b-nvfp4.sh) — launch NVIDIA Qwen3.6-27B-NVFP4 with vLLM
- [nvidia-dgx-spark/gemma-4-31b-it-nvfp4-vllm.yaml](nvidia-dgx-spark/gemma-4-31b-it-nvfp4-vllm.yaml) — Gemma 4 31B NVFP4 recipe definition
- [nvidia-dgx-spark/models-and-recipes.md](nvidia-dgx-spark/models-and-recipes.md) — curated DGX Spark GB10 model-serving recipes, runtimes, and deployment resources
- [assets/](assets/) — architecture diagram (drawio source and rendered SVG)
