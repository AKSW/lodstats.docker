FROM ubuntu

LABEL "MAINTAINER"="Ivan Ermilov <iermilov@informatik.uni-leipzig.de>"

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# update ubuntu trusty
# RUN sed -i "1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse \ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse \ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse \ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" /etc/apt/sources.list
RUN apt-get update

################
# Dependencies #
################

# basic packages
RUN apt-get install -y \
    git python-dev wget \
    librdf0 librdf0-dev python-librdf
RUN apt-get install -y python-setuptools
RUN apt-get install -y python-pip

# java
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# any23
# Anything To Triples (Any23) is a library, a web service and a command line tool that extracts structured data in RDF format from a variety
# of Web documents
RUN wget https://archive.apache.org/dist/any23/1.1/apache-any23-core-1.1.tar.gz -O /any23.tar.gz
RUN tar -zxf /any23.tar.gz
RUN rm /any23.tar.gz
RUN ln -s /apache-any23-core-1.0/bin/any23 /bin/

###############
# Application #
###############

# lodstats_www
RUN apt-get install -y libpq-dev
RUN git clone https://github.com/k00ni/LODStats_WWW.git /lodstats_www
RUN cd /lodstats_www && pip install --pre -r requirements.txt
# pastescript
# sqlalchemy
# pylons
# formalchemy
# psycopg2
# ckanclient
# pika

RUN cd /lodstats_www && python setup.py egg_info
# Build rdfstats package
RUN cd /lodstats_www && paster make-config rdfstats production.ini
# A pluggable command-line frontend, including commands to setup package file layouts
# [paste.paster_command]
#  process_all_datasets = rdfstats.commands.process_all_datasets:ProcessAllDatasets
#  process_by_id = rdfstats.commands.process_by_id:ProcessById
#  lodstats_listener = rdfstats.commands.lodstats_listener:LodstatsListener
#  debug = rdfstats.commands.debugger:Debugger
#  lodstats_update = rdfstats.commands.lodstats_update:LodstatsUpdate
#  lodstats_sync = rdfstats.commands.synchronize_ckan:SynchronizeCkan
RUN sed -i s/REPLACE_WITH_PASSWORD/lodstats/g /lodstats_www/production.ini

# lodstats
RUN git clone https://github.com/AKSW/LODStats /lodstats
RUN cd /lodstats && python setup.py install

# csv2rdf
RUN git clone https://github.com/AKSW/CSV2RDF-WIKI /csv2rdf-wiki
ENV PYTHONPATH /lodstats_www:/csv2rdf-wiki
RUN cp /lodstats_www/production.ini /production.ini

RUN apt-get install -y supervisor
# Supervisor is a client/server system that allows its users to monitor and control a number of processes on UNIX-like operating systems.
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

###########
# VOLUMES #
###########

VOLUME ["/lodstats"]
VOLUME ["/lodstats_www"]
VOLUME ["/csv2rdf-wiki"]

COPY start_processing.sh /start_processing.sh
# Get all datasets ids from DB and push messages to process them to the queue.
RUN chmod +x /start_processing.sh

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

EXPOSE 80
