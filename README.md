# llm-server

Serve local LLMs on NVIDIA DGX Spark with an OpenAI-compatible API. Sparkrun is the recommended path for one or more Sparks; the original direct-Docker launchers remain available for single-Spark use.

## Architecture

![On-prem LLM server architecture](assets/on-prem-llm-server.svg)

Editable diagram source: [assets/on-prem-llm-server.drawio](assets/on-prem-llm-server.drawio).

## Quick start

Install and set up Sparkrun with the official [quick start](https://sparkrun.dev/getting-started/quick-start/).

### Use as a registry (no manual clone required)

Add this repository as a registry and browse its recipes. Sparkrun fetches and manages the registry checkout for you; no manual `git clone` is needed. The registry is declared in [`.sparkrun/registry.yaml`](.sparkrun/registry.yaml).

```sh
sparkrun registry add https://github.com/rajive/llm-server.git
sparkrun list @rajive
```

Run the Gemma 4 31B NVFP4 recipe:

```sh
sparkrun run @rajive/gemma-4-31b-it-nvfp4-vllm
```

The recipe serves `nvidia/Gemma-4-31B-IT-NVFP4` with vLLM and configures a 262,144-token context. Sparkrun manages the recipe's container lifecycle and model setup.

### Use a local checkout

Clone the repository and run the recipe directly from its file:

```sh
git clone https://github.com/rajive/llm-server.git
cd llm-server
sparkrun run ./nvidia-dgx-spark/gemma-4-31b-it-nvfp4-vllm.yaml
```

## Sparkrun recipes

Use `--tp N` to span N DGX Sparks (one GPU per Spark), e.g. `--tp 2` for two Sparks. Choose an N supported by the model, runtime, and available cluster; each recipe lists its image and serving options.

Each recipe table row includes copyable commands for both the registry and a local checkout:

```sh
# Registry
sparkrun run @rajive/<recipe-name> [--tp N]

# Local checkout
sparkrun run ./nvidia-dgx-spark/<recipe-name>.yaml [--tp N]
```

`[--tp N]` is optional notation; omit the brackets when running the command.

### LLMs

| Recipe | Commands | Model | Total Parameters | Active Parameters | Topology<br>[--tp N] |
|---|---|---|---:|---:|---|
| [Gemma 4 31B NVFP4](nvidia-dgx-spark/gemma-4-31b-it-nvfp4-vllm.yaml) | **Registry**<br>`sparkrun run @rajive/gemma-4-31b-it-nvfp4-vllm`<br><br>**Local checkout**<br>`sparkrun run ./nvidia-dgx-spark/gemma-4-31b-it-nvfp4-vllm.yaml` | [`nvidia/Gemma-4-31B-IT-NVFP4`](https://huggingface.co/nvidia/Gemma-4-31B-IT-NVFP4) | 31B | 31B | 1 to N DGX Sparks |
| [Qwen3.6-27B-NVFP4](nvidia-dgx-spark/qwen3.6-27b-nvfp4-vllm.yaml) | **Registry**<br>`sparkrun run @rajive/qwen3.6-27b-nvfp4-vllm`<br><br>**Local checkout**<br>`sparkrun run ./nvidia-dgx-spark/qwen3.6-27b-nvfp4-vllm.yaml` | [`nvidia/Qwen3.6-27B-NVFP4`](https://huggingface.co/nvidia/Qwen-3.6-27B-NVFP4) | 27B | 27B | 1 to N DGX Sparks |
| [Qwen3.6-35B-A3B](nvidia-dgx-spark/qwen3.6-35b-a3b-vllm.yaml) | **Registry**<br>`sparkrun run @rajive/qwen3.6-35b-a3b-vllm`<br><br>**Local checkout**<br>`sparkrun run ./nvidia-dgx-spark/qwen3.6-35b-a3b-vllm.yaml` | [`Qwen/Qwen3.6-35B-A3B`](https://huggingface.co/Qwen/Qwen3.6-35B-A3B) | 35B | 3B | 1 to N DGX Sparks |

### Embeddings

| Recipe | Commands | Model | Total Parameters | Active Parameters | Topology<br>[--tp N] |
|---|---|---|---:|---:|---|
| [BGE-M3](nvidia-dgx-spark/bge-m3-vllm.yaml) | **Registry**<br>`sparkrun run @rajive/bge-m3-vllm`<br><br>**Local checkout**<br>`sparkrun run ./nvidia-dgx-spark/bge-m3-vllm.yaml` | [`BAAI/bge-m3`](https://huggingface.co/BAAI/bge-m3) | 568M | 568M | 1 to N DGX Sparks |
| [Qwen3-Embedding-8B](nvidia-dgx-spark/qwen3-embedding-8b-vllm.yaml) | **Registry**<br>`sparkrun run @rajive/qwen3-embedding-8b-vllm`<br><br>**Local checkout**<br>`sparkrun run ./nvidia-dgx-spark/qwen3-embedding-8b-vllm.yaml` | [`Qwen/Qwen3-Embedding-8B`](https://huggingface.co/Qwen/Qwen3-Embedding-8B) | 8B | 8B | 1 to N DGX Sparks |

## Shell launchers (original path)

The launchers remain useful for learning the direct Docker setup or serving on one DGX Spark. They run `vllm/vllm-openai:latest` (linux/arm64) on the Spark's GB10 GPU, mount the host's Hugging Face cache, and expose the API on port 8000. The Qwen3.6-27B-NVFP4 launcher downloads its model and sets a 131,072-token context limit.

They require the [Hugging Face CLI (`hf`)](https://huggingface.co/docs/huggingface_hub/guides/cli), Docker, and the NVIDIA Container Toolkit on the DGX Spark host.

For DGX Spark setup and deployment guidance, see NVIDIA's [vLLM playbook](https://build.nvidia.com/spark/vllm).

| Launcher | Command | Model | Total Parameters | Active Parameters | Topology |
|---|---|---|---:|---:|---|
| [Qwen3.6-27B-NVFP4](nvidia-dgx-spark/serve-qwen3.6-27b-nvfp4.sh) | `./nvidia-dgx-spark/serve-qwen3.6-27b-nvfp4.sh` | [`nvidia/Qwen3.6-27B-NVFP4`](https://huggingface.co/nvidia/Qwen3.6-27B-NVFP4) | 27B | 27B | 1 DGX Spark |
| [Qwen3.6-35B-A3B](nvidia-dgx-spark/serve-qwen3.6-35b-a3b.sh) | `./nvidia-dgx-spark/serve-qwen3.6-35b-a3b.sh` | [`Qwen/Qwen3.6-35B-A3B`](https://huggingface.co/Qwen/Qwen3.6-35B-A3B) | 35B | 3B | 1 DGX Spark |

## Reference

- [DGX Spark GB10 model and recipe coverage](nvidia-dgx-spark/models-and-recipes.md)
- [Sparkrun registry documentation](https://sparkrun.dev/recipes/registries/) · [Recipe format](https://sparkrun.dev/recipes/format/)
- [Sparkrun documentation](https://sparkrun.dev) · [GitHub repository](https://github.com/spark-arena/sparkrun)
