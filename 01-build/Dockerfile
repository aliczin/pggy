FROM debian:buster-slim

ENV LANG ru_RU.utf8
ENV PG_MAJOR 14
ENV PG_VERSION 14.0

ENV PGDATA /iczin/pgdata
ENV PGDATABASE "" \
    PGUSERNAME "" \
    PGPASSWORD ""

COPY patches /patches

# https://ftp.postgresql.org/pub/source/
# https://codeload.github.com/postgres/postgres/tar.gz/master

RUN set -ex \
        \
        && apt-get update && apt-get install -y \
           ca-certificates \
           curl \
           procps \
           sysstat \
           libldap2-dev \
           libpython-dev \
           libreadline-dev \
           libssl-dev \
           bison \
           flex \
           libghc-zlib-dev \
           libcrypto++-dev \
           libxml2-dev \
           libxslt1-dev \
           bzip2 \
           make \
           gcc \
           unzip \
           python \
           locales \
           perl \
           libfindbin-libs-perl \
           patch \
        \
        && rm -rf /var/lib/apt/lists/* \
        && localedef -i ru_RU -c -f UTF-8 ru_RU.utf8 \
        && mkdir /iczin-guru/ \
        \
        && groupadd -r postgres --gid=999 \
        && useradd -m -r -g postgres --uid=999 postgres \
        && chown postgres:postgres /iczin-guru/ \
        && mkdir -p "$PGDATA" \
        && chown -R postgres:postgres "$PGDATA" \
        && chmod 700 "$PGDATA" \
        \
        && curl -o /home/postgres/postgresql.tar.gz "https://codeload.github.com/postgres/postgres/tar.gz/master" \
        && mkdir -p /home/postgres/src \
        && ls -al /home/postgres/ \
        && chown -R postgres:postgres /home/postgres \
        && su postgres -c "tar \
                xvf \
                /home/postgres/postgresql.tar.gz \
                --directory /home/postgres/src" \
                && rm /home/postgres/postgresql.tar.gz \
        \
        && ls -al /home/postgres/src \
        && cd /home/postgres/src/postgres-master \
        && mv /patches/* ./ \
#        && sh ./apply-patches.sh \ TODO
        && su postgres -c "./configure \
                --enable-integer-datetimes \
                --enable-thread-safety \
                --with-pgport=5432 \
                --prefix=/iczin-guru/app/postgres/product/$PG_VERSION \
                --with-ldap \
                --with-python \
                --with-openssl \
                --with-libxml \
                --with-libxslt" \
        && su postgres -c "make -j 4 all" \
        && su postgres -c "make install" \
        && su postgres -c "make -C contrib install" \
        && rm -rf /home/postgres/src \
        \
        && apt-get update && apt-get purge --auto-remove -y \
           libldap2-dev \
           libpython-dev \
           libreadline-dev \
           libssl-dev \
           libghc-zlib-dev \
           libcrypto++-dev \
           libxml2-dev \
           libxslt1-dev \
           bzip2 \
           gcc \
           make \
           unzip \
           perl \
           libfindbin-libs-perl \
           patch \
        && apt-get install -y libxml2 \
        && rm -rf /var/lib/apt/lists/*