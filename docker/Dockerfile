FROM ubuntu

ARG uid=0
ARG gid=0
ARG user=root

COPY deps-apt /tmp/deps-apt
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $(grep -vE '^#' /tmp/deps-apt) && \
    rm -rf /var/lib/apt/lists/* && \
    rm /tmp/deps-apt

RUN groupadd -g $gid $user \
 && useradd -m -u $uid -g $user $user

RUN mkdir /build \
 && chown $user:$user /build

USER $user
