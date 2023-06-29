#!/bin/sh

set -eux

backupdir=/backup
USER=postgres
NOW=$(date +%Y-%m-%d-%I-%M%p)

# backup globals
mkdir -p $backupdir/postgres_globals
pg_dumpall -U $USER --globals-only | gzip > $backupdir/postgres_globals/$NOW.sql.gz

# backup individual databases
for db in $(psql -U $USER -t -c "select datname from pg_database where not datistemplate" | grep '\S' | awk '{$1=$1};1'); do
    mkdir -p $backupdir/$db
    pg_dump -U $USER $db | gzip > $backupdir/$db/$NOW.sql.gz
done
