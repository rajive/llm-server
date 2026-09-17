# Models supported by sparkrun with ≥ 8B active parameters

Source: sparkrun official + community recipe registries
(github.com/spark-arena/recipe-registry, community-recipe-registry),
cross-checked against HuggingFace configs and model cards.

| Model | Type | Total params | Active params | License |
|---|---|---|---|---|
| MiniMax-M3 (v0) | MoE | ~428B | ~23B | MiniMax (custom) |
| Qwen3.5-397B-A17B | MoE | 397B | 17B | Apache-2.0 |
| GLM-5.3-Flash | MoE | ~320B | ~12B¹ | MIT |
| Nemotron-3-Super-120B-A12B | MoE | 120B | 12B | NVIDIA OML (custom) |
| Qwen3.5-122B-A10B | MoE | 122B | 10B | Apache-2.0 |
| MiniMax-M2 | MoE | 230B | 10B | MiniMax (custom) |
| MiniMax-M2.5 | MoE | ~229B | ~10B² | MiniMax (custom) |
| MiniMax-M2.7 | MoE | 230B | 10B | MiniMax (custom) |
| DeepSeek-V4-Flash (+ Flash-Vision-Exp) | MoE | ~284–304B | ~9B¹ | MIT |
| Qwen3.5-27B | Dense | 27.8B | 27.8B | Apache-2.0 |
| Qwen3.6-27B | Dense | 27.8B | 27.8B | Apache-2.0 |
| Qwen3.8-27B | Dense | 27.8B | 27.8B | Apache-2.0 |
| Qwen3-VL-Reranker-8B | Dense | ~8.8B | ~8.8B | Apache-2.0 |
| Qwen3-VL-Embedding-8B | Dense | ~8.1B | ~8.1B | Apache-2.0 |

## Excluded — supported but < 8B active

| Model | Type | Total params | Active params | License |
|---|---|---|---|---|
| Qwen3-Coder-Next | MoE | 80B | 3B | Apache-2.0 |
| Qwen3.5-35B-A3B | MoE | 35.9B | 3B | Apache-2.0 |
| Qwen3.6-35B-A3B | MoE | 35.9B | 3B | Apache-2.0 |
| GLM-4.7-Flash | MoE | 30B | 3B | MIT |
| Nemotron-3-Nano-30B-A3B | MoE | 30B | 3B | NVIDIA OML (custom) |
| North-Mini-Code-1.0 | MoE | 30B | 3B | Apache-2.0 |
| Gemma-4-26B-A4B | MoE | 26B | 4B | Apache-2.0 |
| GPT-OSS-120B | MoE | 117B | 5.1B | Apache-2.0 |
| Qwen3.8-Flash-Next | MoE | ~180B | 6B | Custom |
| Mistral-Small-4-119B | MoE | 119B | 6.5B | Apache-2.0 |

## Notes

- ¹ DeepSeek-V4-Flash and GLM-5.3-Flash active params are not stated in their
  model cards; computed from their HuggingFace configs (routed experts ×
  active-per-token + dense/attention/embeddings), so ~9B and ~12B are
  estimates. Both sit ≥ 8B, so included.
- ² MiniMax-M2.5 shares M2's exact architecture (62 layers, 256 experts,
  8/tok); M2's official card is 230B/10B, so M2.5 ≈ 10B active.
- ³ The two Qwen3-VL models are embedding/reranker models, not generative
  LLMs (included because their ~8B is fully active).
