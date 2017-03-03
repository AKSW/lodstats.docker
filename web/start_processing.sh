#!/bin/sh

cd /lodstats_www

echo "STARTED CRON JOB" >> /var/log/supervisor/supervisord.log
paster --plugin=rdfstats process_all_datasets
