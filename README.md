lodstats.docker
===============

This is a docker file for LODStats application (front-end + back-end).

Usage
-----

To start the bootstrap process for LODStats run:

```
docker-compose up
```

After this go to `localhost` in your browser.

Docker-Compose Structure
------------------------

The nodes are marking the different Docker container.

![Alt text](https://g.gravizo.com/svg?
  digraph G {
      a [label="web"]
      b [label="rabbitmq"]
      c [label="db"]
      d [label="virtuoso"]
      e [label="nginx"]
      c -> a [label="Exposing PostgreSQL DB"]
      b -> a [label="Message Queue"]
      a -> e [label="LODStats Web Application"]
      d -> e [label="Exposing LODStats SPARQL Endpoint"]
  })

### db
Exposes Postgresql data base which contains statistical information for LODStats.

### rabbitmq
Message queue which processes the aggregated dumps for LODStats.

### web
Contains the [LODStats web application](https://github.com/k00ni/LODStats_WWW) which depends on **db** and **rabbitmq**.

### virtuoso
Exposes a sparql endpoint, which contains a RDF representation of **db**, to the **nginx** container.

### nginx
Brings the web application and the virtuose endpoint together and makes them accessible through the host system.


Changes to original repository
------------------------------

-	Added `LOAD_DUMP` environment variable for Virtuoso container to control the long process of dumping the RDF file to the Virtuoso store
