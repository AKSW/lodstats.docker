#!/bin/sh

sed -i s/REPLACE_WITH_THE_HOST/${POSTGRES_PORT_5432_TCP_ADDR}:${POSTGRES_PORT_5432_TCP_PORT}/g /lodstats_www/production.ini

/usr/bin/supervisord
