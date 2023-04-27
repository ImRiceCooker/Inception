#!/bin/sh

openssl req -newkey rsa:2048 -nodes -keyout "/etc/ssl/${INTRA_ID}.42.fr.key" \
    -x509 -days 365 -out "/etc/ssl/${INTRA_ID}.42.fr.crt" \
    -subj "/CN=${INTRA_ID}.42.fr" -addext "subjectAltName=DNS:${INTRA_ID}.42.fr" \
    2>/dev/null

echo "nginx ready, port is 443"

exec nginx -g 'daemon off;'
