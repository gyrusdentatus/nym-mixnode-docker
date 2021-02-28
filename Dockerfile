FROM bitnami/minideb:buster AS builder

RUN set -ex \
    && install_packages libssl1.1 ca-certificates curl \
    && useradd -U -m -s /sbin/nologin nym

WORKDIR /home/nym

COPY check.sh .
# Change onwership and permissions
RUN chmod +x check.sh && chown -R nym:nym ./

USER nym

#VOLUME [ "/home/nym/.nym" ]


EXPOSE 1789

CMD [ "./check.sh" ]
#ENTRYPOINT [ "/bin/bash" ]
