# DGX Spark GB10 model and recipe coverage

**Last reviewed:** 2026-09-23

This page is a curated snapshot of public model-serving evidence for NVIDIA
DGX Spark systems with the GB10 Grace Blackwell Superchip. It is not an
exhaustive list of every model that can run on 128 GB of unified memory.

The live registries are authoritative. This page summarizes their coverage,
records notable model families, and links to the operational resources needed
to deploy them.

Topology gives the number of interconnected DGX Spark systems in the linked
profile. Active parameters are those used per token; dense models have the same
total and active count. Parameter counts are model metadata, not a memory
guarantee.

**Browse model profiles:** [text and code](#text-and-code) ·
[vision-language](#vision-language) · [diffusion and video](#diffusion-and-video) ·
[embedding and reranking](#embedding-and-reranking) ·
[unverified leads](#unverified-leads) ·
[using recipes with this repository](#using-recipes-with-this-repository)

## Evidence labels

- **NVIDIA playbook**: the model or deployment appears in an NVIDIA DGX Spark
  playbook. This does not establish that the exact checkpoint and launcher were
  tested together.
- **vLLM GB10 verified / supported**: the vLLM catalog explicitly gives the
  selected hardware variant that status. Check the exact precision and task;
  the default command may target another GPU.
- **Spark Arena recipe listed**: a recipe exists in the linked registry. Its
  `official`, `experimental`, or `community` namespace is shown in the recipe
  label; namespace is provenance, not a measure of validation.
- **Community recipe listed**: a maintained Spark-specific recipe exists
  outside Spark Arena.
- **Forum report**: a user-reported deployment without a maintained recipe.

An **experimental deployment** is a separate qualification: the profile
requires a custom runtime, B12X kernels, model-specific patches, or a
model-specific loader. It is not equivalent to upstream vLLM support; check
the linked profile's requirements regardless of registry namespace.

These evidence types are not interchangeable. A generic model page or a model
that fits in memory is not evidence of a tested GB10 deployment. Topology is
the Spark count in the linked profile, not necessarily the smallest working or
tested configuration. Do not transfer evidence to another checkpoint or
variant.

## Curated model inventory

Each row is a representative profile with a Spark-specific recipe or explicit
Spark deployment evidence; it does not cover every checkpoint in that family.
**Recipe(s)** labels include source provenance and link to the exact variant,
YAML, or deployment instructions. **Evidence** describes what that source
establishes, not a general confidence judgment. Check linked vLLM GB10 variants
rather than assuming a model page's default command targets Spark. Runtime,
image, context, and parallelism details vary by source; consult the recipe.
Requirements are limited to profile-specific deployment constraints; Atlas-linked
profiles use the Atlas runtime.

### Text and code

| Model | Total Params | Active Params | Topology | Recipe(s) | Evidence | Requirements |
|---|---:|---:|---:|---|---|---|
| Nemotron-3-Ultra NVFP4 | 550B | 55B | 4 Sparks | [Eugr community — NVFP4 YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/4x-spark-cluster/nemotron-3-ultra-nvfp4.yaml) | Community recipe listed | Experimental cluster image |
| Gemma 4 31B NVFP4 | 31B | 31B | 1 Spark | [Atlas community — NVFP4 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/gemma4/gemma-4-31b-nvfp4.yaml) | Community recipe listed | — |
| Qwen3.5-27B NVFP4 | 27B | 27B | 1 Spark | [Atlas community — NVFP4 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/qwen3.5/qwen3.5-27b-dense-nvfp4.yaml) | Community recipe listed | — |
| Qwen3.6-27B FP8 | 27B | 27B | 1 Spark | [Spark Arena official — FP8 YAML](https://github.com/spark-arena/recipe-registry/blob/main/official-recipes/qwen3.6/vllm/qwen3.6-27b-fp8-vllm.yaml) | Spark Arena recipe listed | — |
| Qwen3.8-27B FP8 | 27B | 27B | 1 Spark | [Spark Arena official — FP8 MTP YAML](https://github.com/spark-arena/recipe-registry/blob/main/official-recipes/qwen3.8/qwen3.8-27b-fp8-mtp-vllm.yaml) | Spark Arena recipe listed | — |
| MiniMax-M3 NVFP4 REAP25 | 427B | 26B | 2 Sparks | [Spark Arena experimental — SGLang REAP25 YAML](https://github.com/spark-arena/recipe-registry/blob/main/experimental-recipes/minimax-m3/minimax-m3-v0-nvfp4-2x-reap25.yaml); [Spark Arena experimental — 4-Spark profile](https://github.com/spark-arena/recipe-registry/tree/main/experimental-recipes/minimax-m3) | Spark Arena recipe listed | — |
| GLM-5.3-Flash NVFP4 | 321B | 18B | 2 Sparks | [Eugr community — NVFP4 YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/glm-5.3-flash.yaml) | Community recipe listed | Requires experimental B12X image; recipe uses MTP speculative decoding |
| Qwen3.5-397B-A17B INT4 | 397B | 17B | 2 Sparks | [Spark Arena experimental — 2-Spark INT4 YAML](https://github.com/spark-arena/recipe-registry/blob/main/experimental-recipes/eugr-vllm/qwen3.5-397b-a17b-int4-autoround-2x-vllm.yaml); [Eugr community — 3-Spark INT4](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/3x-spark-cluster/qwen3.5-397b-int4-autoround.yaml); [Eugr community — 4-Spark FP8](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/4x-spark-cluster/qwen3.5-397b-a17B-fp8.yaml) | Spark Arena recipe listed | Custom image and chat-template patch |
| DeepSeek-V4-Flash-0731 | 304B | 13B | 2 Sparks | [Spark Arena official — B12X/DSpark YAML](https://github.com/spark-arena/recipe-registry/blob/main/official-recipes/deepseek4-flash/deepseek-v4-flash-0731-b12x-dspark-vllm.yaml); [Eugr community — B12X/DSpark recipe](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/deepseek-v4-flash-0731.yaml) | Spark Arena recipe listed | Both profiles require the experimental B12X stack and configure DSpark speculative decoding. Spark Arena additionally applies `instanttensor-hybrid-draft-loader`. The NVFP4 model-card evaluation used B200 and did not exercise speculative decoding; it does not validate these Spark profiles. |
| Nemotron-3-Super-120B-A12B NVFP4 | 120B | 12B | 1 Spark | [Spark Arena experimental — 1-Spark NVFP4 YAML](https://github.com/spark-arena/recipe-registry/blob/main/experimental-recipes/nemotron-3-super/nemotron-3-super-nvfp4-mtp-1x-vllm.yaml); [Eugr community — 2-Spark recipe](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/nemotron-3-super-nvfp4.yaml) | Spark Arena recipe listed | — |
| MiniMax-M2.7 AWQ | 230B | 10B | 2 Sparks | [Spark Arena official — AWQ YAML](https://github.com/spark-arena/recipe-registry/blob/main/official-recipes/minimax-m2.7/minimax-m2.7-awq4-vllm.yaml) | Spark Arena recipe listed | — |
| Qwen3.5-122B-A10B NVFP4 | 122B | 10B | 1 Spark | [Atlas community — 1-Spark NVFP4 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/qwen3.5/qwen3.5-122b-a10b-nvfp4-single.yaml); [Eugr community — INT4 2-Spark recipe](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/qwen3.5-122b-int4-autoround.yaml) | Community recipe listed | Atlas 1-Spark profile has tight KV-cache headroom |
| Mistral Small 4 FP8 | 119B | 6.5B | 2 Sparks | [Spark Arena community — FP8 YAML](https://github.com/spark-arena/community-recipe-registry/blob/main/recipes/mistral-small-4-119b-2603/t4cmyk/mistral-small-4-119b-2603-fp8-vllm-t4cmyk.yaml) | Spark Arena recipe listed | — |
| Qwen3.8-Flash-Next NVFP4 | 176B | 6B | 1 Spark | [Eugr community — 1-Spark YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/qwen3.8-flash-next-nvfp4-solo.yaml); [Eugr community — 2-Spark YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/qwen3.8-flash-next-nvfp4-cluster.yaml) | Community recipe listed | 1-Spark profile requires PLE table disk offload and experimental B12X |
| GPT-OSS-20B | 21B | 3.6B | 1 Spark | [NVIDIA playbook — SGLang deployment](https://build.nvidia.com/spark/sglang) | NVIDIA playbook | — |
| GPT-OSS-120B | 120B | 5.1B | 1 Spark | [Eugr community — vLLM YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/openai-gpt-oss-120b.yaml) | Community recipe listed | Use the recipe's model-specific image and launch settings |
| Ling-3.0-flash FP4 / INT4 | 124B | 5.5B | 1 Spark | [vLLM — GB10 variants](https://recipes.vllm.ai/inclusionAI/Ling-3.0-flash?hw=dgx_spark_gb10) | GB10 verified | GB10 support is for TP1 FP4/INT4; BF16 and FP8 exceed unified memory |
| Gemma 4 26B-A4B NVFP4 | 26B | 4B | 1 Spark | [Atlas community — NVFP4 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/gemma4/gemma-4-26b-a4b-nvfp4.yaml) | Community recipe listed | — |
| Qwen3-Next-80B-A3B NVFP4 | 80B | 3B | 1 Spark | [Atlas community — NVFP4 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/qwen3-next/qwen3-next-80b-a3b-nvfp4.yaml) | Community recipe listed | — |
| GLM-4.7-Flash AWQ | 30B | 3B | 1 Spark | [Eugr community — AWQ YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/glm-4.7-flash-awq.yaml) | Community recipe listed | Recipe describes a speed patch, but leaves it disabled; enable it for the stated inference-speed optimization |
| Nemotron-3-Nano-30B-A3B NVFP4 | 30B | 3B | 1 Spark | [Atlas community — NVFP4 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/nemotron-3-nano/nemotron-3-nano-30b-a3b-nvfp4.yaml) | Community recipe listed | — |
| Nemotron-3.5-Lightning-30B-A3B | 30B | 3B | 1 Spark | [Eugr community — DSpark YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/nemotron-3.5-lightning.yaml) | Community recipe listed | Recipe defaults to TP=2 for a cluster; use TP=1 for the listed single-Spark profile. DSpark speculative decoding is configured. |
| North-Mini-Code-1.0 FP8 | 30B | 3B | 1 Spark | [Spark Arena community — FP8 YAML](https://github.com/spark-arena/community-recipe-registry/blob/main/recipes/north-mini-code-1.0/XanuNetworks/north-mini-code-1.0-fp8-vllm-XanuNetworks.yaml) | Spark Arena recipe listed | — |
| Qwen3.5-35B-A3B NVFP4 | 35B | 3B | 1 Spark | [Atlas community — NVFP4 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/qwen3.5/qwen3.5-35b-a3b-nvfp4.yaml) | Community recipe listed | — |
| Qwen3.6-35B-A3B FP8 | 35B | 3B | 1 Spark | [Spark Arena official — FP8 YAML](https://github.com/spark-arena/recipe-registry/blob/main/official-recipes/qwen3.6/vllm/qwen3.6-35b-a3b-fp8-vllm.yaml); [vLLM — upstream GB10 profile](https://recipes.vllm.ai/Qwen/Qwen3.6-35B-A3B/hw/dgx_spark_gb10.json) | Spark Arena recipe listed | Follow the chosen profile; settings differ |
| Qwen3.5-0.8B BF16 | 0.8B | 0.8B | 1 Spark | [Atlas community — BF16 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/qwen3.5/qwen3.5-0.8b-bf16-atlas.yaml) | Community recipe listed | — |
| Step 3.7 Flash NVFP4 | 198B | 11B | 2 Sparks | [Eugr community — NVFP4 YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/step-3.7-flash-nvfp4.yaml) | Community recipe listed | — |
| GLM-5.2 NVFP4 | 743B | 39B | 8 Sparks | [Eugr community — NVFP4 YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/8x-spark-cluster/glm-5.2-nvfp4.yaml) | Community recipe listed | Experimental runtime/image |
| Inkling-Small NVFP4 | 276B | 12B | 2 Sparks | [Eugr community — NVFP4 YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/inkling-small-nvfp4.yaml) | Community recipe listed | Experimental |

### Vision-language

| Model | Total Params | Active Params | Topology | Recipe(s) | Evidence | Requirements |
|---|---:|---:|---:|---|---|---|
| Muse-Glimmer-30B BF16 | 29.6B | 29.6B | 1 Spark | [vLLM — GB10 variant](https://recipes.vllm.ai/meta-models/Muse-Glimmer-30B?hw=dgx_spark_gb10) | vLLM GB10 verified | — |
| Qwen3-VL-30B-A3B NVFP4 | 30B | 3B | 1 Spark | [Atlas community — NVFP4 YAML](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/qwen3-vl/qwen3-vl-30b-a3b-nvfp4.yaml) | Community recipe listed | — |

### Diffusion and video

These profiles serve generation tasks other than chat; use the task-specific
runtime and endpoints in their recipes.

| Model | Total Params | Active Params | Topology | Recipe(s) | Evidence | Requirements |
|---|---:|---:|---:|---|---|---|
| LTX-2.5-Diffusers FP8 | 19B | 19B | 1 Spark | [vLLM-Omni — GB10 FP8 variant](https://recipes.vllm.ai/Lightricks/LTX-2.5-Diffusers?hw=dgx_spark_gb10) | vLLM GB10 supported, not verified | — |
| DiffusionGemma 26B-A4B | 26B | 4B | 1 Spark | [Eugr community — BF16 YAML](https://github.com/eugr/spark-vllm-docker/blob/main/recipes/diffusion-gemma-bf16.yaml) | Community recipe listed | — |
| MiniMax-H3 FP8 (one DiT) | 64B | 64B | 1 Spark | [vLLM-Omni — GB10 recipe](https://recipes.vllm.ai/MiniMaxAI/MiniMax-H3?hw=dgx_spark_gb10) | vLLM GB10 verified | Gated weights, current vLLM-Omni main, `--task-type fl2va` or `ref2va`; full BF16 service needs more memory |

### Embedding and reranking

These retrieval workloads use task-specific pooling runners, not chat-serving
recipes. Each row links to its exact checkpoint and runtime configuration.

| Model | Total Params | Active Params | Topology | Recipe(s) | Evidence | Requirements |
|---|---:|---:|---:|---|---|---|
| Qwen3-VL-Embedding-8B / multimodal embeddings | 8B | 8B | 1 Spark | [Spark Arena official — embedding YAML](https://github.com/spark-arena/recipe-registry/blob/main/official-recipes/qwen3-vl/vllm/qwen3-vl-embedding-8b-vllm.yaml) | Spark Arena recipe listed | — |
| Qwen3-VL-Reranker-8B / multimodal reranking | 8B | 8B | 1 Spark | [Spark Arena official — reranker YAML](https://github.com/spark-arena/recipe-registry/blob/main/official-recipes/qwen3-vl/vllm/qwen3-vl-reranker-8b-vllm.yaml) | Spark Arena recipe listed | — |

## Unverified leads

These candidates and reports may be useful starting points, but they do not
meet the curated inventory's evidence threshold.

### Upstream catalog candidates

The vLLM catalog is larger than the curated table and changes frequently. As
of this snapshot, candidates requiring explicit Spark-filter verification
include Qwen3-Coder-480B-A35B, Qwen3-VL-235B-A22B, DeepSeek-V4-Pro,
DeepSeek-V4.1-Flash, Kimi families, MiMo families, Intern-S2, audio/TTS/OCR
models, and additional Cosmos and image-generation models. Check the
`dgx_spark_gb10` hardware metadata and exact variant; a generic model page is
not evidence of a Spark deployment.

### Forum reports

| Model | Evidence | Status |
|---|---|---|
| `cyankiwi/bu-30b-a3b-preview-AWQ-4bit` | [NVIDIA forum report](https://forums.developer.nvidia.com/t/359704) | Forum-reported, 1 Spark |
| `lukealonso/GLM-4.6-NVFP4` | [NVIDIA forum report](https://forums.developer.nvidia.com/t/353723) | Forum-reported, 2 Sparks |
| `nemotron-3-super:120b` | [NVIDIA forum report](https://forums.developer.nvidia.com/t/364355) | Ollama/OpenShell, not vLLM |

## Using recipes with this repository

The [local `vllm-server` script](vllm-server) downloads and launches
`Qwen/Qwen3.6-35B-A3B` with `vllm/vllm-openai:latest`, TP1, and a configured
131,072-token maximum context. That is **not** the [Spark Arena FP8
profile](https://github.com/spark-arena/recipe-registry/blob/main/official-recipes/qwen3.6/vllm/qwen3.6-35b-a3b-fp8-vllm.yaml)
in the table: it names `Qwen/Qwen3.6-35B-A3B-FP8`, its own image and mods, and
a 262,144-token context setting. The [upstream vLLM GB10
variant](https://recipes.vllm.ai/Qwen/Qwen3.6-35B-A3B/hw/dgx_spark_gb10.json)
uses the same checkpoint as the local script but different parser and runtime
settings. Neither source validates the local launch command as a whole.
Follow the exact GB10 variant or registry launcher and its runtime requirements
when reproducing a listed profile; do not swap only the model name in the local
script.

The [single-Spark Atlas Gemma 4 recipe](https://github.com/Avarok-Cybersecurity/atlas-recipes/blob/main/recipes/gemma4/gemma-4-31b-nvfp4.yaml)
uses the Atlas runtime. It is not a drop-in model selection for the local vLLM
script. This repository does not include run records validating its local
launcher against the inventory profiles.

## Operational resources

### Eugr Spark vLLM Docker

The [Eugr repository](https://github.com/eugr/spark-vllm-docker) provides
single- and multi-node launchers, model distribution, InstantTensor,
fastsafetensors, NVFP4/MXFP4 paths, NCCL/RDMA setup, Ray or native distributed
launches, B12X images, and model-specific patches. Its [recipe directory](https://github.com/eugr/spark-vllm-docker/tree/main/recipes)
is the source for many rows above. Read its [networking guide](https://github.com/eugr/spark-vllm-docker/blob/main/docs/NETWORKING.md)
before attempting multi-Spark serving.

### Spark Arena and sparkrun

Use `sparkrun list`, `sparkrun show`, and `sparkrun run` against the official
and community namespaces. The registries expose recipe YAML, required image,
and runtime flags; VRAM estimates and benchmark metadata vary by recipe. A
recipe filename is more precise than a model-family name, so record it when
documenting a tested deployment.

### NVIDIA platform setup

Use NVIDIA's [vLLM multi-node playbook](https://build.nvidia.com/spark/vllm)
and the [Connect Two Sparks playbook](https://build.nvidia.com/spark/connect-two-sparks)
for QSFP connectivity, SSH, and cluster setup. The [NCCL playbook](https://build.nvidia.com/spark/nccl)
is the relevant validation path for distributed communication.

### Model format and memory

GB10 has 128 GB of unified memory, shared by the GPU and Grace CPU. The usable
budget depends on the OS, containers, runtime allocations, KV cache, context
length, multimodal encoders, and offload settings. A parameter count alone is
not a deployment guarantee. Check quantization, context length, tensor/pipeline
parallelism, KV-cache dtype, image revision, and custom patches.

## Canonical live sources

### Model-serving registries

- [vLLM DGX Spark recipes](https://recipes.vllm.ai/browse?panel=open&hw=dgx_spark_gb10)
- [vLLM recipe JSON catalog](https://recipes.vllm.ai/models.json)
- [Spark Arena official recipes](https://github.com/spark-arena/recipe-registry)
- [Spark Arena community recipes](https://github.com/spark-arena/community-recipe-registry)
- [sparkrun CLI](https://github.com/spark-arena/sparkrun)
- [sparkrun documentation](https://sparkrun.dev)
- [Spark Arena leaderboard](https://spark-arena.com/leaderboard)
- [Eugr Spark vLLM recipes](https://github.com/eugr/spark-vllm-docker/tree/main/recipes)
- [Avarok Atlas recipes](https://github.com/Avarok-Cybersecurity/atlas-recipes)
- [Avarok DGX vLLM](https://github.com/Avarok-Cybersecurity/dgx-vllm)

### NVIDIA DGX Spark playbooks

- [DGX Spark playbook catalog](https://build.nvidia.com/spark)
- [vLLM](https://build.nvidia.com/spark/vllm)
- [SGLang](https://build.nvidia.com/spark/sglang)
- [llama.cpp](https://build.nvidia.com/spark/llama-cpp)
- [TensorRT-LLM](https://build.nvidia.com/spark/trt-llm)
- [NIM](https://build.nvidia.com/spark/nim-llm)
- [multimodal inference](https://build.nvidia.com/spark/multi-modal-inference)
- [speculative decoding](https://build.nvidia.com/spark/speculative-decoding)
- [NVFP4 quantization](https://build.nvidia.com/spark/nvfp4-quantization)
- [Connect two Sparks](https://build.nvidia.com/spark/connect-two-sparks)
- [Connect three Sparks](https://build.nvidia.com/spark/connect-three-sparks)
- [NCCL](https://build.nvidia.com/spark/nccl)

The inventory draws mainly from vLLM and model-specific Spark recipes.
The llama.cpp playbook covers GGUF serving rather than a fixed model list;
TensorRT-LLM and NIM are not inventoried model-by-model here.

### Other NVIDIA Spark resources

The catalog also includes playbooks for ComfyUI, Open WebUI, LM Studio,
OpenShell, agents, RAG, JAX, CUDA-X data science, and fine-tuning with NeMo,
Llama Factory, PyTorch, and Unsloth. These support the broader platform rather
than serving profiles in the inventory.

## Maintenance rules

When adding a model or recipe:

1. Name the exact model and quantized checkpoint IDs; link the exact variant
   or YAML, not only its model-family page.
2. Record the published runtime, image tag or source commit, and context
   setting when recording a deployment; mark unavailable fields as “not
   published.” An image tag such as `latest` is not an immutable version.
3. Record the published topology. Call it tested or the smallest tested only
   when a linked run or benchmark supports that claim.
4. Label custom kernels, forks, patches, loaders, and offload requirements.
5. Put source provenance in the recipe label and use an evidence category from
   the definitions above. Record experimental dependencies separately.
6. The page-level **Last reviewed** date applies to this inventory snapshot;
   update it after an inventory review. For an independently checked entry or
   run, add its check date in the requirements column or linked run record.
   Neither date is a benchmark date unless accompanied by a benchmark result.
