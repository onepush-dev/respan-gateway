# Respan Gateway on Railway

[Respan Gateway](https://github.com/respanai/respan-gateway) (Apache-2.0 / MIT) is a single Rust binary LLM gateway: OpenAI Chat, OpenAI Responses, Anthropic Messages and Gemini clients can call any model, with fallback, retries, hedged requests, MCP tools and a live call log in a web UI.

This repo holds the Railway packaging for v0.3.0: `ghcr.io/onepush-dev/respan-gateway:0.3.0` is the upstream `ghcr.io/respanai/respan-gateway:0.3.0` (pinned by digest), binary unchanged, listening on `[::]:8080` so the public domain and Railway's private network both reach it.

`RESPAN_CLIENT_KEYS` is generated per deploy; every request needs it as `Authorization: Bearer`, `x-api-key` or `x-goog-api-key`, and it also unlocks the web UI at `/ui/`. Add provider keys (`OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `GEMINI_API_KEY`, `GROQ_API_KEY`, …) as service variables; each one becomes a provider.
