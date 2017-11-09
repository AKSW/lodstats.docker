#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE lodstats WITH LOGIN ENCRYPTED PASSWORD 'lodstats' CREATEDB;
    CREATE DATABASE lodstats WITH OWNER lodstats TEMPLATE template0 ENCODING 'UTF8';
    GRANT ALL PRIVILEGES ON DATABASE lodstats TO lodstats;
EOSQL

cat /data/lodstats_dump.sql | psql -d lodstats --username "$POSTGRES_USER"
