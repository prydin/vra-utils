#!/bin/sh
PG_DBNAME=$1
PG_USER=$2
PG_PASSWORD=$3

apt install -y postgresql

PG_VERSION=`ls -1 /etc/postgresql/`
echo "listen_addresses = '*'" >> /etc/postgresql/$PG_VERSION/main/postgresql.conf

sudo -u postgres psql -U postgres postgres <<SQL
    CREATE ROLE $PG_USER LOGIN
    ENCRYPTED PASSWORD '$PG_PASSWORD'
    NOSUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
SQL

echo "local     all             all                     password" >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf
echo "host      $PG_DBNAME      $PG_USER    0.0.0.0/0   md5" >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf
echo "track_counts = on" >> /etc/postgresql/$PG_VERSION/main/postgresql.conf
echo "autovacuum = on" >> /etc/postgresql/$PG_VERSION/main/postgresql.conf
service postgresql restart

# Signal that initialization is done
touch /tmp/postgres-running