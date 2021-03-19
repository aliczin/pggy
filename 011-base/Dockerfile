FROM postgres-master-vanilla:latest

#default postgresuser postgrepassword and database testing
ENV PGDATABASE testing
ENV PGUSERNAME postgresuser
ENV PGPASSWORD postgrepassword

COPY simple-docker-entrypoint.sh /
VOLUME /iczin/pgdata

STOPSIGNAL SIGINT

ENV LANG ru_RU.utf8
USER postgres
EXPOSE 5432
ENTRYPOINT ["/simple-docker-entrypoint.sh"]
