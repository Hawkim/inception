FROM alpine:3.21.3

RUN apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-session \
    php82-opcache \
    php82-phar \
    php82-curl \
    php82-mbstring \
    curl \
    mariadb-client

# Fix WP-CLI memory exhaustion
RUN echo "memory_limit = 256M" > /etc/php82/conf.d/memory.ini

# Fix socket binding
RUN sed -i 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf

# Install WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x wp-cli.phar \
 && mv wp-cli.phar /usr/local/bin/wp

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

WORKDIR /var/www/html

ENTRYPOINT ["/setup.sh"]
