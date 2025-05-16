FROM mariadb:10.6

COPY tools/init.sql /docker-entrypoint-initdb.d/init.sql
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]
