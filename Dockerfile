FROM debian:10

# Install basic environment dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    pkg-config \
    ufw \
    build-essential \
    libssl-dev

# Install Rust
#RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --verbose
#ENV PATH=/root/.cargo/bin:$PATH
#RUN rustc -vV && cargo -V

RUN useradd -d /home/nym/ -m -p nym -s /usr/sbin/nologin
# Clean up apt packages so the docker image is as compact as possible
RUN apt-get clean && apt-get autoremove

# Donwload nym-mixnode binaries
#RUN cd /home/nym && curl -LO https://github.com/nymtech/nym/releases/download/v0.7.0/nym-mixnode_linux_x86_64 \
#chmod +x nym-mixnode_linux_x86_64

WORKDIR /home/nym

COPY nym-mixnode_linux_x86_64 .
COPY nym_install_docker.sh .
RUN chmod 755 nym-mixnode_linux_x86_64 && chmod 755 nym_install_docker.sh
USER nym
EXPOSE 1789

CMD ./nym_install.sh -i
