FROM ubuntu:14.04

MAINTAINER Ivan Ermilov <iermilov@informatik.uni-leipzig.de>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# update ubuntu trusty
RUN sed -i "1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse \ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse \ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse \ndeb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" /etc/apt/sources.list
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
RUN wget http://apache.mirrors.lucidnetworks.net/any23/1.1/apache-any23-core-1.1.tar.gz -O /any23.tar.gz
RUN tar -zxf /any23.tar.gz
RUN rm /any23.tar.gz
RUN ln -s /apache-any23-core-1.0/bin/any23 /bin/

###############
# Application #
###############

# lodstats_www
RUN apt-get install -y libpq-dev
RUN git clone https://github.com/AKSW/LODStats_WWW /lodstats_www
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
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

########
# Cron #
########

#ADD crons.conf /crons.conf
#RUN crontab /crons.conf
#RUN cron

###########
# VOLUMES #
###########

VOLUME ["/lodstats"]
VOLUME ["/lodstats_www"]
VOLUME ["/csv2rdf-wiki"]

ADD start_processing.sh /start_processing.sh
# Get all datasets ids from DB and push messages to process them to the queue.
RUN chmod +x /start_processing.sh

ADD start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]

EXPOSE 80
# production.ini
#
# rdfstats - Pylons configuration
#
# The %(here)s variable will be replaced with the parent directory of this file
#
# [DEFAULT]
# debug = true
# email_to = you@yourdomain.com
# smtp_server = localhost
# error_email_from = paste@localhost
#
# [server:main]
# use = egg:Paste#http
# host = 0.0.0.0
# port = 5000
#
# [app:main]
# use = egg:rdfstats
# full_stack = true
# static_files = true
#
# cache_dir = %(here)s/data
# beaker.session.key = rdfstats
# beaker.session.secret = UUSVRGf3dKvZG9WZqjOiYrhlw
# app_instance_uuid = e8e95438-da39-40ae-8bfb-ca6c78692c30
#
# # If you'd like to fine-tune the individual locations of the cache data dirs
# # for the Cache data, or the Session saves, un-comment the desired settings
# # here:
# #beaker.cache.data_dir = %(here)s/data/cache
# #beaker.session.data_dir = %(here)s/data/sessions
#
# # SQLAlchemy database URL
# sqlalchemy.url = postgres://lodstats:lodstats@REPLACE_WITH_THE_HOST/lodstats
#
# # WARNING: *THE LINE BELOW MUST BE UNCOMMENTED ON A PRODUCTION ENVIRONMENT*
# # Debug mode will enable the interactive debugging tool, allowing ANYONE to
# # execute malicious code after an exception is raised.
# set debug = false
#
# # CKAN base and api key
# ckan.base = http://thedatahub.org/
# ckan.api_key = REPLACE_ME_WITH_YOUR_API_KEY
#
# # Logging configuration
# [loggers]
# keys = root
#
# [handlers]
# keys = console
#
# [formatters]
# keys = generic
#
# [logger_root]
# level = INFO
# handlers = console
#
# [handler_console]
# class = StreamHandler
# args = (sys.stderr,)
# level = NOTSET
# formatter = generic
#
# [formatter_generic]
# format = %(asctime)s %(levelname)-5.5s [%(name)s] [%(threadName)s] %(message)s
