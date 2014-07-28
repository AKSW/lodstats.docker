#!/bin/sh

sed -i s/.*client_encoding\ =\ sql_ascii/client_encoding\ =\ utf8/g /etc/postgresql/9.3/main/postgresql.conf
echo "starting postgres..."
service postgresql start

sudo -u postgres psql lodstats < /lodstats-cleaned.dump

cd /lodstats_www && paster serve production.ini
