#!/bin/sh

sed -i s/REPLACE_WITH_THE_HOST/${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/g /lodstats_www/production.ini
sed -i s/rabbitmqHost\ =\ \"__RABBITMQHOST__\"/rabbitmqHost=\"${RABBITMQ_PORT_5672_TCP_ADDR}\"/g /csv2rdf-wiki/csv2rdf/messaging/__init__.py

/usr/bin/supervisord
