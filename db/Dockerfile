FROM postgres:9.5.2

MAINTAINER "Ivan Ermilov <mailto:ivan.s.ermilov@gmail.com>"

RUN apt-get update
RUN apt-get install -y wget

COPY entrypoint.sh /docker-entrypoint-initdb.d/
