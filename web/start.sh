#!/bin/sh

sed -i s/REPLACE_WITH_THE_HOST/${LODSTATS_DB}:5432/g /lodstats_www/production.ini
sed -i s/rabbitmqHost\ =\ \"__RABBITMQHOST__\"/rabbitmqHost=\"${RABBITMQ}\"/g /csv2rdf-wiki/csv2rdf/messaging/__init__.py

/usr/bin/supervisord
