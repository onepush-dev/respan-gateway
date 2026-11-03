# Respan Gateway on Railway

[Respan Gateway](https://github.com/respanai/respan-gateway) (Apache-2.0 / MIT) is a single Rust binary LLM gateway: OpenAI Chat, OpenAI Responses, Anthropic Messages and Gemini clients can call any model, with fallback, retries, hedged requests, MCP tools and a live call log in a web UI.

This repo holds the Railway packaging for v0.3.0. `ghcr.io/onepush-dev/respan-gateway:0.3.0` carries the upstream release binary from `ghcr.io/respanai/respan-gateway:0.3.0` (pinned by digest), unchanged, on `debian:bookworm-slim`, listening on `[::]:8080` so the public domain and Railway's private network both reach it.

- `RESPAN_CLIENT_KEYS` is generated per deploy. Every request needs it as `Authorization: Bearer`, `x-api-key` or `x-goog-api-key`, and it also unlocks the web UI at `/ui/` and the admin API.
- Upstream refuses to start without a provider, so `railway/start.sh` picks the config: `RESPAN_CONFIG` (a file path), else `RESPAN_GATEWAY_TOML` (a whole `gateway.toml` pasted into a Railway variable), else the provider keys in the environment (`OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `GEMINI_API_KEY`, `GROQ_API_KEY`, `OPENROUTER_API_KEY`, `DEEPSEEK_API_KEY`, `XAI_API_KEY`, `MISTRAL_API_KEY`, …: each becomes a provider), else a placeholder provider so the gateway and UI boot. Add a key in Variables and the redeploy picks it up.
