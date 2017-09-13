#!/bin/bash
set -e

wget https://www.dropbox.com/s/xszbuq2fnj9z9x3/lodstats_dump_13-09-2017_17_20_05.sql.gz -O /lodstats.dump.gz
gunzip /lodstats.dump.gz

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE lodstats WITH LOGIN ENCRYPTED PASSWORD 'lodstats' CREATEDB;
    CREATE DATABASE lodstats WITH OWNER lodstats TEMPLATE template0 ENCODING 'UTF8';
    GRANT ALL PRIVILEGES ON DATABASE lodstats TO lodstats;
EOSQL

pg_restore --username "$POSTGRES_USER" -d lodstats -v /lodstats.dump
