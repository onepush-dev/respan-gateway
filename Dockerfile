# Respan Gateway 0.3.0 (respanai/respan-gateway, Apache-2.0 / MIT) for Railway.
# The upstream release binary from ghcr.io/respanai/respan-gateway:0.3.0 (pinned by digest), unchanged,
# on debian:bookworm-slim (same glibc as upstream's distroless cc-debian12) so a small start script can
# pick the config: RESPAN_CONFIG > RESPAN_GATEWAY_TOML (config pasted into a Railway variable) >
# provider keys in the environment (upstream's no-config mode) > a placeholder provider, so the
# gateway and its web UI boot before any provider key is added.
FROM ghcr.io/respanai/respan-gateway:0.3.0@sha256:e8be642e4c321533e109fe46a9e8c51acf1dc48cfb8af047badf5c27c4f7c57c AS upstream

FROM debian:bookworm-slim@sha256:99c0b25c46d0214d5a2091092e7908907dcaecd6a962cde0ac700acee222b6f3
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates tini \
 && rm -rf /var/lib/apt/lists/* \
 && useradd --system --uid 65532 --home-dir /app --shell /usr/sbin/nologin respan \
 && mkdir -p /app && chown respan /app
COPY --from=upstream /usr/local/bin/respan-gateway /usr/local/bin/respan-gateway
COPY --chmod=0755 railway/start.sh /usr/local/bin/railway-start
COPY railway/placeholder.toml /etc/respan/placeholder.toml
# Listen on [::]:8080 (dual-stack): Railway's public domain, healthcheck and the IPv6 private network.
ENV PORT=8080 \
    RESPAN_LISTEN=[::]:8080 \
    RESPAN_LOG=text \
    RESPAN_COLOR=never
WORKDIR /app
USER 65532
EXPOSE 8080
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/railway-start"]
