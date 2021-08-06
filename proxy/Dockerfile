FROM jwilder/dockerize AS dockerize
FROM haproxy:2.4-alpine

ENV TUNNEL_TARGET_HOST ""
ENV TUNNEL_TARGET_PORT ""
ENV TUNNEL_LISTEN "10000"

ENV TCP_PROXY_TIMEOUT_CONNECT "10s"
ENV TCP_PROXY_TIMEOUT_CLIENT "30s"
ENV TCP_PROXY_TIMEOUT_SERVER "180s"
ENV TCP_PROXY_MAXCONN "50"

COPY --from=dockerize /usr/local/bin/dockerize /usr/local/bin/dockerize
COPY entrypoint.sh /entrypoint.sh
COPY haproxy.cfg.tmpl /haproxy.cfg.tmpl

USER root

RUN chmod +x /usr/local/bin/dockerize /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg" ]
