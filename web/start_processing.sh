#!/bin/sh

echo "STARTED CRON JOB: process_all_datasets" >> /var/log/supervisor/supervisord.log

cd /lodstats_www && paster --plugin=rdfstats process_all_datasets
