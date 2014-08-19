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
RUN wget http://mirror.derwebwolf.net/apache/any23/1.0/apache-any23-core-1.0.tar.gz -O /any23.tar.gz
RUN tar -zxf /any23.tar.gz
RUN rm /any23.tar.gz
RUN ln -s /apache-any23-core-1.0/bin/any23 /bin/

# rabbitmq
RUN apt-get install -y rabbitmq-server


############
# DATABASE #
############
# install postgres
RUN apt-get install -y postgresql
RUN apt-get install -y --fix-missing libpq-dev

# get the LODStats DB dump
RUN wget https://dl.dropboxusercontent.com/u/4882345/lodstats-dumps/lodstats-cleaned.dump.bz2 -O /lodstats-cleaned.dump.bz2
RUN bunzip2 /lodstats-cleaned.dump.bz2

# fix the encoding in the postgres config
RUN sed -i s/.*client_encoding\ =\ sql_ascii/client_encoding\ =\ utf8/g /etc/postgresql/9.3/main/postgresql.conf

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Create users and populate the database
USER postgres

RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER lodstats With PASSWORD 'lodstats';" &&\
    createdb -O lodstats lodstats &&\
    psql lodstats < /lodstats-cleaned.dump

###############
# Application #
###############

# Switch back to root user
USER root

# lodstats 
RUN git clone https://github.com/AKSW/LODStats /lodstats
RUN cd /lodstats && python setup.py install

# lodstats_www 
RUN git clone https://github.com/AKSW/LODStats_WWW /lodstats_www
RUN cd /lodstats_www && pip install --pre -r requirements.txt

RUN cd /lodstats_www && python setup.py egg_info
RUN cd /lodstats_www && paster make-config rdfstats production.ini
RUN sed -i s/REPLACE_WITH_PASSWORD/lodstats/g /lodstats_www/production.ini

#RUN apt-get install -y supervisor
#RUN mkdir -p /var/log/supervisor
#COPY supervisord.conf /etc/supervisor/conf.d/

ADD start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]

EXPOSE 5000
