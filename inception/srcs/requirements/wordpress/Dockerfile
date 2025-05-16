FROM alpine:3.18

RUN apk add --no-cache php81 php81-fpm php81-mysqli php81-session curl mariadb-client

COPY tools/setup.sh /setup.sh

WORKDIR /var/www/html
RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
CMD ["php-fpm81", "-F"]
