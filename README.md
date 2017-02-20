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
----------------------

The nodes are marking the different Docker container.

![Alt text](https://g.gravizo.com/svg?
  digraph G {
      a [label="web"]
      b [label="rabbitmq"]
      c [label="db"]
      d [label="virtuoso"]
      e [label="nginx"]
      c -> a [label="Exposing\nPostgreSQL DB"]
      b -> a [label="Message Queue"]
      a -> e [label="LODStats\nWeb Application"]
      d -> e [label="Exposing LODStats\nSPARQL Endpoint"]
  })

Changes to original repository
----------------------

- Added `LOAD_DUMP` environment variable for Virtuoso container to control the long process of dumping the RDF file to the Virtuoso store
