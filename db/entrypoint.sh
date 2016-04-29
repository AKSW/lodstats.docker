#!/bin/bash
set -e

wget https://dl.dropboxusercontent.com/u/4882345/lodstats-dumps/28-04-2015.dump -O /lodstats.dump

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE lodstats WITH LOGIN ENCRYPTED PASSWORD 'lodstats' CREATEDB;
    CREATE DATABASE lodstats WITH OWNER lodstats TEMPLATE template0 ENCODING 'UTF8';
    GRANT ALL PRIVILEGES ON DATABASE lodstats TO lodstats;
EOSQL

pg_restore --username "$POSTGRES_USER" -d lodstats -v /lodstats.dump
