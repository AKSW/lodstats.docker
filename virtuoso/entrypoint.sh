#!/bin/bash
set -e

mkdir -p /data/toLoad
wget https://www.dropbox.com/s/g4arhua0jmfi2jw/lodstats.nt -O /data/toLoad/lodstats.nt

/bin/bash /virtuoso.sh
