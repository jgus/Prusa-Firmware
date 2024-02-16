FROM ubuntu:22.04

COPY deps-apt /tmp/deps-apt
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $(grep -vE '^#' /tmp/deps-apt) && \
    rm -rf /var/lib/apt/lists/* && \
    rm /tmp/deps-apt

# RUN ./utils/bootstrap.py
