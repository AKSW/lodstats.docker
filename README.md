lodstats.docker
===============

This is a docker file for LODStats application (front-end + back-end).

Deployment
================
Download the lodstats RDF dump (142MB download size, 3GB uncompressed) and DB dump (113.80MB download size, 1.7GB uncompressed):
```
make download
```

Deploy:
```
docker-compose up -d
```

Note: nginx might go down if it starts too soon to find the hosts. To fix, just restart it.

Docker Image HDD footprint
================

| Image Name  | HDD footprint |
| ------------- | ------------- |
| postgres:9.6.5  | 266MB  |
| rabbitmq:3.6.1  | 176MB  |
| tenforce/virtuoso:1.3.0-virtuoso7.2.4  | 606MB  |
| nginx:1.13.6  | 108MB  |
