#!/bin/sh

# Wait for MariaDB to be ready
until nc -z mariadb 3306; do
  echo "Waiting for MariaDB to be ready..."
  sleep 2
done
echo "MariaDB is ready!"

# Export environment variable values
export MYSQL_DATABASE=${MYSQL_DATABASE:-wordpress_db}
export MYSQL_USER=${MYSQL_USER:-wp_user}
export MYSQL_PASSWORD=${MYSQL_PASSWORD:-admin}
export WP_ADMIN_USER=${WP_ADMIN_USER:-admin}
export WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD:-admin}
export WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL:-admin@example.com}
export WP_TITLE=${WP_TITLE:-Inception Site}
export WP_URL=${WP_URL:-https://localhost}

cd /var/www/html

# Clean broken wp-config.php
rm -f wp-config.php

# Download and configure WordPress if not already installed
if [ ! -f wp-config.php ]; then
  wp core download --allow-root

  wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="mariadb" \
    --allow-root

  wp core install \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root
fi

# Start PHP-FPM in the foreground
exec php-fpm81 -F
