#!/bin/bash
set -e

mkdir -p /data/toLoad
wget https://dl.dropboxusercontent.com/u/4882345/lodstats-rdf/30042016/lodstats.nt -O /data/toLoad/lodstats.nt

/bin/bash /virtuoso.sh
