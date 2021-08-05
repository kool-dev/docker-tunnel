#!/bin/sh

exec autossh -M 0 -- -T -N -oStrictHostKeyChecking=no -oServerAliveInterval=180 -oUserKnownHostsFile=/dev/null -L "*:${TUNNEL_LISTEN}:${TUNNEL_TARGET_HOST}:${TUNNEL_TARGET_PORT}" -p ${TUNNEL_SSH_PORT} ${TUNNEL_SSH_USER}@${TUNNEL_SSH_HOST}
