FROM alpine:3.21.3

RUN apk add --no-cache nginx openssl

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 443

ENTRYPOINT ["/setup.sh"]
CMD ["nginx", "-g", "daemon off;"]
