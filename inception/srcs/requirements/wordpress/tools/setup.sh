#!/bin/sh

# Load environment
DB_HOST="mariadb"
DB_USER="${MYSQL_USER}"
DB_NAME="${MYSQL_DATABASE}"
DB_PASSWORD=$(cat /run/secrets/db_password)

# Wait for MariaDB
echo "Waiting for MariaDB to be ready..."

MAX_ATTEMPTS=30
ATTEMPT=1

while ! mysqladmin ping -h "$DB_HOST" --silent; do
  if [ "$ATTEMPT" -ge "$MAX_ATTEMPTS" ]; then
    echo "MariaDB not reachable after $MAX_ATTEMPTS attempts. Exiting."
    exit 1
  fi
  echo "Attempt $ATTEMPT: still waiting..."
  ATTEMPT=$((ATTEMPT + 1))
  sleep 2
done

echo "MariaDB is ready!"

# Start php-fpm
exec php-fpm81 -F
