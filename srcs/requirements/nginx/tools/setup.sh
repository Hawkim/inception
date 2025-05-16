#!/bin/sh

CERT_DIR="/etc/nginx/certs"

mkdir -p "$CERT_DIR"

openssl req -x509 -nodes -days 365 \
  -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=neil.42.fr" \
  -newkey rsa:2048 \
  -keyout /etc/nginx/certs/selfsigned.key \
  -out /etc/nginx/certs/selfsigned.crt

exec "$@"

