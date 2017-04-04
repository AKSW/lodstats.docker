#!/bin/bash
set -e

if [ "$LOAD_DUMP" == "true" ]; then
  mkdir -p /data/toLoad
  wget https://dl.dropboxusercontent.com/u/4882345/lodstats-rdf/30042016/lodstats.nt -O /data/toLoad/lodstats.nt
else
  echo "Do not load dump file.";
fi

/bin/bash /virtuoso.sh
