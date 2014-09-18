#!/bin/sh

#start docker container
sudo docker run --name lodstats-postgres -d postgres

#download DB dump
wget https://dl.dropboxusercontent.com/u/4882345/lodstats-dumps/lodstats-18082014.dump.bz2 -O lodstats.dump.bz2
bunzip2 lodstats.dump.bz2

#create lodstats role
echo "CREATE ROLE lodstats WITH LOGIN ENCRYPTED PASSWORD 'lodstats' CREATEDB;" | sudo docker run --rm --interactive --link lodstats-postgres:postgres postgres bash -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

#Create the database
echo "CREATE DATABASE lodstats WITH OWNER lodstats TEMPLATE template0 ENCODING 'UTF8';" | sudo docker run --rm --interactive --link lodstats-postgres:postgres postgres bash -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

#grant all privileges on lodstats to lodstats
echo "GRANT ALL PRIVILEGES ON DATABASE lodstats TO lodstats;" | sudo docker run --rm --interactive --link lodstats-postgres:postgres postgres bash -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'

#load dump into the database
sudo docker run   --rm   --interactive   --link lodstats-postgres:postgres   --volume $PWD/:/tmp/   postgres   bash -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -d lodstats < /tmp/lodstats.dump'

