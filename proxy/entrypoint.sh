#!/bin/sh

set -e

# parses config file
dockerize -template /haproxy.cfg.tmpl:/usr/local/etc/haproxy/haproxy.cfg

# call original image entrypoint
exec /usr/local/bin/docker-entrypoint.sh "$@"
