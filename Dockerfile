FROM rust:1.34.2

RUN apt-get update -qy \
    && apt-get install -qy curl ca-certificates --no-install-recommends \
    && echo "Pulling watchdog binary from Github." \
    && curl -sSL https://github.com/openfaas/faas/releases/download/0.13.0/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog \
    && apt-get -qy remove curl \
    && apt-get clean \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . ./proj
WORKDIR proj

RUN cargo build --package rust-youtube-serverless --verbose --jobs 4 --bin rust-youtube --release

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1
ENV fprocess=/app/proj/target/release/rust-youtube
CMD ["fwatchdog"]
