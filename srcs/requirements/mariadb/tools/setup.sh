#!/bin/sh


DB_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-admin}
DB_PASSWORD=${MYSQL_PASSWORD:-admin}

# Start MariaDB with entrypoint script
exec /usr/local/bin/docker-entrypoint.sh mysqld
