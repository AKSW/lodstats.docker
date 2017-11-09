#!/bin/sh

echo "Subbing the variables in production.ini"
echo "LODSTATS_DB: $LODSTATS_DB"
echo "RABBITMQ: $RABBITMQ"
sed -i s/REPLACE_WITH_THE_HOST/${LODSTATS_DB}:5432/g /lodstats_www/production.ini
sed -i s/rabbitmqHost\ =\ \"__RABBITMQHOST__\"/rabbitmqHost=\"${RABBITMQ}\"/g /csv2rdf-wiki/csv2rdf/messaging/__init__.py
sed -i s/port\ =\ 5000/port=80/g /lodstats_www/production.ini

/usr/local/bin/paster serve /lodstats_www/production.ini
