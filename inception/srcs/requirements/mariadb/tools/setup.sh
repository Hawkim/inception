#!/bin/sh

# Load passwords from Docker secrets
export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password.txt)
export MYSQL_PASSWORD=$(cat /run/secrets/db_password.txt)

# Start MariaDB with entrypoint script
exec /usr/local/bin/docker-entrypoint.sh mysqld
