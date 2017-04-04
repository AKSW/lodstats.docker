FROM postgres:9.5.2

MAINTAINER "Ivan Ermilov <mailto:ivan.s.ermilov@gmail.com>"

ENV POSTGRES_USER postgres

RUN apt-get update && apt-get install -y wget

COPY init-lodstats-db.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init-lodstats-db.sh

# postgres container will execute all scripts in docker-entrypoint-initdb.d folder
# https://hub.docker.com/_/postgres/
