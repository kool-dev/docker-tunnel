FROM alpine:3.14

ENV TUNNEL_SSH_USER ""
ENV TUNNEL_SSH_HOST ""
ENV TUNNEL_SSH_PORT "22"
ENV TUNNEL_TARGET_HOST ""
ENV TUNNEL_TARGET_PORT ""
ENV TUNNEL_LISTEN ""

# build image dependencies
RUN apk add --update autossh && rm -rf /var/cache/apk/*

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
