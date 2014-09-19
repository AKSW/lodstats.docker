sudo docker run   --interactive   --link lodstats-postgres:postgres   --volume $PWD/:/tmp/   postgres   bash -c 'exec pg_dump -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -F tar -v -d lodstats > /tmp/lodstats.tar'