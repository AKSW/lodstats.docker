FROM tenforce/virtuoso

LABEL "maintainer"="Ivan Ermilov <mailto:ivan.s.ermilov@gmail.com>" "maintainer"="georges.alkhouri@gmail.com"

ENV LOAD_DUMP false

RUN apt-get update
RUN apt-get install -y wget

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
