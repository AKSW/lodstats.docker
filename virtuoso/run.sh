#!/bin/bash
set -e

# removed, because it takes a long time to load the dump
#mkdir -p /data/toLoad
#wget https://dl.dropboxusercontent.com/u/4882345/lodstats-rdf/30042016/lodstats.nt -O /data/toLoad/lodstats.nt

/bin/bash /virtuoso.sh
