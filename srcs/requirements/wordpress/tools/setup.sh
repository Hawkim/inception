#!/bin/sh

# Wait for MariaDB to be ready
until nc -z mariadb 3306; do
  echo "Waiting for MariaDB to be ready..."
  sleep 2
done
echo "MariaDB is ready!"

# Export environment variables with fallbacks
export MYSQL_DATABASE=${MYSQL_DATABASE:-wordpress_db}
export MYSQL_USER=${MYSQL_USER:-wp_user}
export MYSQL_PASSWORD=${MYSQL_PASSWORD:-admin}
export WP_ADMIN_USER=${WP_ADMIN_USER:-mainuser}
export WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD:-securepass}
export WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL:-admin@example.com}
export WP_TITLE=${WP_TITLE:-InceptionSite}
export WP_URL=${WP_URL:-https://localhost}
export DOMAIN_NAME=${DOMAIN_NAME:-localhost}

cd /var/www/html

# Install WordPress if not already installed
if [ ! -f wp-config.php ]; then
  echo "Downloading WordPress core..."
  wp core download --allow-root

  echo "Creating wp-config.php..."
  wp config create \
    --dbname="${MYSQL_DATABASE}" \
    --dbuser="${MYSQL_USER}" \
    --dbpass="${MYSQL_PASSWORD}" \
    --dbhost="mariadb" \
    --allow-root

  echo "Installing WordPress site..."
  wp core install \
    --url="${WP_URL}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root

  echo "Creating second user 'guest'..."
  wp user create guest guest@${DOMAIN_NAME} \
    --user_pass=guestpass \
    --role=author \
    --allow-root

  echo "✅ WordPress installation complete with two users."
else
  echo "WordPress is already installed."
fi

# Start PHP-FPM in foreground
exec php-fpm82 -F
