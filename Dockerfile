FROM alpine:3.14

ENV TUNNEL_SSH_USER ""
ENV TUNNEL_SSH_HOST ""
ENV TUNNEL_SSH_PORT "22"
ENV TUNNEL_TARGET_HOST ""
ENV TUNNEL_TARGET_PORT ""
ENV TUNNEL_LISTEN ""

# build image dependencies
RUN apk add --update autossh && rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/autossh", "-M", "0", "-T", "-N", "-oStrictHostKeyChecking=no", "-oServerAliveInterval=180", "-oUserKnownHostsFile=/dev/null", "-L"]

CMD ["*:${TUNNEL_LISTEN}:${TUNNEL_TARGET_HOST}:${TUNNEL_TARGET_PORT}", "-p ${TUNNEL_SSH_PORT}", "${TUNNEL_SSH_USER}@${TUNNEL_SSH_HOST}"]
