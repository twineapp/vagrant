#!/bin/sh

# to run manually
#	vagrant ssh
#	. /var/www/vagrant/src/scripts/postgres.build.sh

echo "twine database build script"
#terminate current connections
sudo -u postgres psql -q -c "SELECT pg_terminate_backend(pid) FROM pg_stat_get_activity(NULL::integer) WHERE datid=(SELECT oid from pg_database where datname = 'twine');" > /dev/null 2>&1
#drop database
sudo -u postgres psql -q -c "DROP DATABASE IF EXISTS twine;" > /dev/null 2>&1
# create database
sudo -u postgres psql -q -c "CREATE DATABASE twine WITH TEMPLATE=template0 OWNER=admin ENCODING='UTF8' LC_COLLATE='en_US.utf8' LC_CTYPE='en_US.utf8';"

echo "    changing directory to /var/www/vagrant/src/postgres"
cd /var/www/vagrant/src/postgres

echo "    creating siv_app schema and tables"
sudo -u postgres psql -q twine < siv_app.sql > /dev/null 2>&1
echo "    populating siv_app tables"
sudo -u postgres psql -q twine < siv_app.data.sql > /dev/null 2>&1

echo "    creating siv_data schema and tables"
sudo -u postgres psql -q twine < siv_data.sql > /dev/null 2>&1
echo "    populating siv_data tables"
sudo -u postgres psql -q twine < siv_data.data.sql > /dev/null 2>&1

echo "    creating siv_users schema and tables"
sudo -u postgres psql -q twine < siv_users.sql > /dev/null 2>&1
echo "    populating siv_users tables"
sudo -u postgres psql -q twine < siv_users.data.sql > /dev/null 2>&1

echo "    adjusting auto increments"
sudo -u postgres psql -q twine < siv.ai.sql > /dev/null 2>&1

echo "    creating database users"
sudo -u postgres psql -q twine < siv.dbusers.sql > /dev/null 2>&1

echo "    applying SQL patches"
for f in /var/www/vagrant/src/postgres/siv.[0-9][0-9].sql; do
	sudo -u postgres psql -q twine < "$f" > /dev/null 2>&1
done

echo "twine database build script complete"
