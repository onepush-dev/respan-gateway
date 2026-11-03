# Respan Gateway 0.3.0 (respanai/respan-gateway, Apache-2.0 / MIT) for Railway: the upstream image,
# binary unchanged. Only change: listen on [::]:8080 (dual-stack) instead of 0.0.0.0:$PORT, so
# Railway's public domain, healthcheck AND the IPv6 private network
# (http://respan-gateway.railway.internal:8080) all reach it.
FROM ghcr.io/respanai/respan-gateway:0.3.0@sha256:e8be642e4c321533e109fe46a9e8c51acf1dc48cfb8af047badf5c27c4f7c57c
ENV PORT=8080 \
    RESPAN_LISTEN=[::]:8080 \
    RESPAN_LOG=text \
    RESPAN_COLOR=never
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/respan-gateway"]
