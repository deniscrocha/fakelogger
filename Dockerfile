# ----------------------------------------------------
# BUILD
# ----------------------------------------------------
FROM ubuntu:24.04 AS builder

RUN apt update && apt install -y curl build-essential xz-utils

WORKDIR /opt

RUN curl -LO https://ziglang.org/builds/zig-x86_64-linux-0.16.0-dev.1484+d0ba6642b.tar.xz && \
    tar -xf zig-x86_64-linux-0.16.0-dev.1484+d0ba6642b.tar.xz && \
    mv zig-x86_64-linux-0.16.0-dev.1484+d0ba6642b zig

ENV PATH="/opt/zig:${PATH}"

WORKDIR /app

COPY . .

RUN zig build-exe main.zig -Drelease-fast=true -lc

# ----------------------------------------------------
# EXEC
# ----------------------------------------------------

FROM ubuntu:24.04
WORKDIR /app
COPY --from=builder /app/main /app/main
ENTRYPOINT ["/app/main"]
