#!/bin/sh

# to run manually
#	vagrant ssh
#	. /var/www/vagrant/src/scripts/postgres.build.sh

instance=twine

echo "Creating twine ($instance instance) database"
#terminate current connections
sudo -u postgres psql -q -c "SELECT pg_terminate_backend(pid) FROM pg_stat_get_activity(NULL::integer) WHERE datid=(SELECT oid from pg_database where datname = '$instance');" > /dev/null 2>&1
#drop database
sudo -u postgres psql -q -c "DROP DATABASE IF EXISTS $instance;" > /dev/null 2>&1
# create database
sudo -u postgres psql -q -c "CREATE DATABASE $instance WITH TEMPLATE=template0 OWNER=admin ENCODING='UTF8' LC_COLLATE='en_US.utf8' LC_CTYPE='en_US.utf8';"

echo "    changing directory to /var/www/vagrant/src/postgres"
cd /var/www/vagrant/src/postgres

echo "    create extensions"
sudo -u postgres psql -q $instance < pre.extensions.sql

echo "    creating siv_app schema and tables"
sudo -u postgres psql -q $instance < siv_app.sql > /dev/null 2>&1
echo "    populating siv_app tables"
sudo -u postgres psql -q $instance < siv_app.data.sql > /dev/null 2>&1

echo "    creating siv_data schema and tables"
sudo -u postgres psql -q $instance < siv_data.sql > /dev/null 2>&1
echo "    populating siv_data tables"
sudo -u postgres psql -q $instance < siv_data.data.sql > /dev/null 2>&1

echo "    creating siv_users schema and tables"
sudo -u postgres psql -q $instance < siv_users.sql > /dev/null 2>&1
echo "    populating siv_users tables"
sudo -u postgres psql -q $instance < siv_users.data.sql > /dev/null 2>&1

echo "    adjusting auto increments"
sudo -u postgres psql -q $instance < post.autoincrement.sql > /dev/null 2>&1

echo "    creating database users"
sudo -u postgres psql -q $instance < $instance.dbusers.sql > /dev/null 2>&1

echo "    applying general SQL patches"
for f in [0-9][0-9].sql; do
	sudo -u postgres psql -q $instance < "$f" > /dev/null 2>&1
done
echo "    applying $instance SQL patches"
for f in $instance.[0-9][0-9].sql; do
	sudo -u postgres psql -q $instance < "$f" > /dev/null 2>&1
done

echo "    restating apache"
sudo service apache2 restart

echo "... twine ($instance instance) db creation script complete"
