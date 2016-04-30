FROM tenforce/virtuoso

MAINTAINER "Ivan Ermilov <mailto:ivan.s.ermilov@gmail.com>"

RUN apt-get update
RUN apt-get install -y wget

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
