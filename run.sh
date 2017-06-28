#!/bin/bash
set -x

#export Test=${TEST}

confd -log-level="debug" -onetime -backend env 
echo "Sleeping 5 seconds..."
service memcached start
# Wait until postgres is up .. dirty :)
sleep 5
service sogo start
nginx &
tail -f /var/log/sogo/sogo.log 
# Keep running if everything fails
tail -f /dev/null
