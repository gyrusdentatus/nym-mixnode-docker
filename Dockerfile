FROM bitnami/minideb:buster

RUN set -ex \
    && install_packages libssl1.1 ca-certificates curl \
    && useradd -U -m -s /sbin/nologin nym
# Clean up apt packages so the docker image is as compact as possible

WORKDIR /home/nym

COPY check.sh .
# Change onwership and permissions
RUN chmod 755 nym-mixnode_linux_x86_64 && chown -R nym:nym ./ && check.sh

COPY nym-mixnode_linux_x86_64 .

VOLUME [ "/home/nym/.nym" ]
#ENTRYPOINT ["/usr/bin/tini", "-v", "--"]

USER nym
EXPOSE 1789

CMD [ "/home/nym/nym-mixnode_linux_x86_64", "run", "--id", "nym"]
