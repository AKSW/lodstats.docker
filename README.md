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

![Alt text](https://g.gravizo.com/svg?%20digraph%20G%20%7B%0A%20%20%20%20%20%20a%20%5Blabel%3D%22web%22%5D%0A%20%20%20%20%20%20b%20%5Blabel%3D%22rabbitmq%22%5D%0A%20%20%20%20%20%20c%20%5Blabel%3D%22db%22%5D%0A%20%20%20%20%20%20d%20%5Blabel%3D%22virtuoso%22%5D%0A%20%20%20%20%20%20e%20%5Blabel%3D%22nginx%22%5D%0A%20%20%20%20%20%20c%20-%3E%20a%20%5Blabel%3D%22Exposing%20PostgreSQL%20DB%22%5D%0A%20%20%20%20%20%20b%20-%3E%20a%20%5Blabel%3D%22Message%20Queue%22%5D%0A%20%20%20%20%20%20a%20-%3E%20e%20%5Blabel%3D%22LODStats%20Web%20Application%22%5D%0A%20%20%20%20%20%20d%20-%3E%20e%20%5Blabel%3D%22Exposing%20LODStats%20SPARQL%20Endpoint%22%5D%0A%20%20%7D)

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
