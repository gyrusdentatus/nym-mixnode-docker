FROM ubuntu:latest

# Install basic environment dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    pkg-config \
    build-essential \
    libssl-dev \
    python3

RUN useradd -U -m -s /sbin/nologin nym
# Clean up apt packages so the docker image is as compact as possible
RUN apt-get clean && apt-get autoremove

WORKDIR /home/nym

COPY nym-mixnode_linux_x86_64 .

# Change onwership and permissions
RUN chmod 755 nym-mixnode_linux_x86_64 && chown -R nym:nym ./
USER nym
EXPOSE 1789

CMD /bin/bash
