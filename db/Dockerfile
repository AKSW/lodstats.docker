FROM postgres:9.5.2

MAINTAINER "Ivan Ermilov <mailto:ivan.s.ermilov@gmail.com>"

RUN apt-get update
RUN apt-get install -y wget

COPY init-lodstats-db.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init-lodstats-db.sh
# postgres container will execute all scripts in docker-entrypoint-initdb.d folder
