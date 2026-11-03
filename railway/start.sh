#!/bin/sh
# Picks the gateway's config, then execs the unmodified upstream binary.
set -eu
BIN=/usr/local/bin/respan-gateway
if [ -n "${RESPAN_CONFIG:-}" ]; then
  echo "railway-start: config file $RESPAN_CONFIG"
  exec "$BIN" serve --watch
fi
if [ -n "${RESPAN_GATEWAY_TOML:-}" ]; then
  printf '%s\n' "$RESPAN_GATEWAY_TOML" > /tmp/gateway.toml
  echo "railway-start: config from RESPAN_GATEWAY_TOML"
  exec "$BIN" --config /tmp/gateway.toml serve
fi
if "$BIN" check >/dev/null 2>&1; then
  echo "railway-start: providers from the provider keys in the environment"
  exec "$BIN" serve
fi
echo "railway-start: no provider key yet. Add OPENAI_API_KEY, ANTHROPIC_API_KEY, GEMINI_API_KEY, GROQ_API_KEY, OPENROUTER_API_KEY, ... (or RESPAN_GATEWAY_TOML) to this service's Variables; until then a placeholder provider answers 502."
exec "$BIN" --config /etc/respan/placeholder.toml serve
