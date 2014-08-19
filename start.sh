#!/bin/sh

service postgresql start

cd /lodstats_www && paster serve production.ini
