FROM alpine:3.18

# Install PHP + needed extensions + tools
RUN apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-session \
    php81-phar \
    php81-iconv \
    curl \
    mariadb-client

# Fix PHP-FPM binding for Docker use
RUN sed -i 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php81/php-fpm.d/www.conf

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x wp-cli.phar \
 && mv wp-cli.phar /usr/local/bin/wp

# Copy and prepare setup script
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

WORKDIR /var/www/html

# Set entrypoint after all binaries and dependencies are in place
ENTRYPOINT ["/setup.sh"]
