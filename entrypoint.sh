#!/bin/bash
/docker-entrypoint.sh postgres &
sleep 5
echo "Processing data"
createdb jsondb
python3 jsondb.py "$@"
python /usr/local/lib/python2.7/dist-packages/pgadmin4/pgAdmin4.py
