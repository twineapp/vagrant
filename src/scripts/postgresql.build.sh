#!/bin/sh

# to run manually
#	vagrant ssh
#	. sudo -u postgres bash /var/www/vagrant/src/scripts/postgresql.build.sh

echo "... creating twine database"
#terminate current connections
sudo -u postgres psql -q -c "SELECT pg_terminate_backend(pid) FROM pg_stat_get_activity(NULL::integer) WHERE datid=(SELECT oid from pg_database where datname = 'twine');" > /dev/null 2>&1
#drop database
sudo -u postgres psql -q -c "DROP DATABASE IF EXISTS twine;" > /dev/null 2>&1
# create database
sudo -u postgres psql -q -c "CREATE DATABASE twine WITH TEMPLATE=template0 OWNER=admin ENCODING='UTF8' LC_COLLATE='en_US.utf8' LC_CTYPE='en_US.utf8';"

echo "... changing directory to /var/www/vagrant/src/postgresql"
cd /var/www/vagrant/src/postgresql

echo "... creating siv_app schema and tables"
sudo -u postgres psql -q twine < siv_app.sql > /dev/null 2>&1
echo "... populating siv_app tables"
sudo -u postgres psql -q twine < siv_app.data.sql > /dev/null 2>&1

echo "... creating siv_data schema and tables"
sudo -u postgres psql -q twine < siv_data.sql > /dev/null 2>&1
echo "... populating siv_data tables"
sudo -u postgres psql -q twine < siv_data.data.sql > /dev/null 2>&1

echo "... creating siv_users schema and tables"
sudo -u postgres psql -q twine < siv_users.sql > /dev/null 2>&1
echo "... populating siv_users tables"
sudo -u postgres psql -q twine < siv_users.data.sql > /dev/null 2>&1

echo "... adjusting auto increments"
sudo -u postgres psql -q twine < siv.ai.sql > /dev/null 2>&1

echo "... creating database users"
sudo -u postgres psql -q twine < siv.dbusers.sql > /dev/null 2>&1

echo "... script complete"
