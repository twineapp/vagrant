#!/bin/sh

echo "Initializing PostgreSQL datadrive and PostGIS extension..."
/etc/init.d/postgresql stop
mkdir -p /var/datadrive/postgresql
chmod -R 700 /var/datadrive/postgresql
chown -R postgres.postgres /var/datadrive/postgresql
sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D /var/datadrive/postgresql
sed 's,/var/lib/postgresql/9.3/main,/var/datadrive/postgresql,g' /etc/postgresql/9.3/main/postgresql.conf > tmpfile && mv tmpfile /etc/postgresql/9.3/main/postgresql.conf
/etc/init.d/postgresql start
sudo -u postgres psql -c "CREATE ROLE admin WITH LOGIN SUPERUSER CREATEDB CREATEROLE PASSWORD 'admin'"
sudo -u postgres psql -c "CREATE EXTENSION postgis;"
sudo -u postgres psql -c "CREATE EXTENSION postgis_topology;"
echo "Allowing connections to phpPgAdmin from all"
sed 's,allow from 127.0.0.0/255.0.0.0 ::1/128,allow from all,g' /etc/apache2/conf.d/phppgadmin > tmpfile && mv tmpfile /etc/apache2/conf.d/phppgadmin
/etc/init.d/apache2 reload