#!/bin/sh

# build / patch files are placed in /var/www/vagrant/src/postgres/
# ensure that only patch files for a single instance are located in the directory

# !! password suffix is specified in line 54
# !! schema build queries must be edited to add in instance specific variable

# to run manually
#	vagrant ssh
#	. /var/www/vagrant/src/scripts/postgres.build.sh

# add  > /dev/null 2>&1 to end of line to supress output

instance=twine
baseurl=siv-v3
usersuffix=_unhcr

echo "Creating twine ($instance instance) database"
#terminate current connections
sudo -u postgres psql -q -c "SELECT pg_terminate_backend(pid) FROM pg_stat_get_activity(NULL::integer) WHERE datid=(SELECT oid from pg_database where datname = '$instance');"
#drop database
sudo -u postgres psql -q -c "DROP DATABASE IF EXISTS $instance;"
# create database
sudo -u postgres psql -q -c "CREATE DATABASE $instance WITH TEMPLATE=template0 OWNER=admin ENCODING='UTF8' LC_COLLATE='en_US.utf8' LC_CTYPE='en_US.utf8';"

echo "    changing directory to /var/www/vagrant/src/postgres"
cd /var/www/vagrant/src/postgres

echo "    create extensions"
sudo -u postgres psql -q $instance < pre.extensions.sql

echo "    creating siv_app schema and tables"
sudo -u postgres psql -q $instance -v v_instance="$instance" < siv_app.sql
echo "    populating siv_app tables"
sudo -u postgres psql -q $instance < siv_app.data.sql

echo "    creating siv_data schema and tables"
sudo -u postgres psql -q $instance -v v_instance="$instance" < siv_data.sql
echo "    populating siv_data tables"
sudo -u postgres psql -q $instance < siv_data.data.sql

echo "    creating siv_users schema and tables"
sudo -u postgres psql -q $instance -v v_instance="$instance" < siv_users.sql
echo "    populating siv_users tables"
sudo -u postgres psql -q $instance < siv_users.data.sql

echo "    creating siv_staging schema and tables"
sudo -u postgres psql -q $instance -v v_instance="$instance" < siv_staging.sql

echo "    adjusting auto increments"
sudo -u postgres psql -q $instance < post.autoincrement.sql

echo "    creating database users"
sudo -u postgres psql -q $instance -v v_instance="$instance"  -v v_usersuffix="$usersuffix" -v v_pwd1="'unhcr'" -v v_pwd2="'unhcr'" < siv.dbusers.sql

echo "    applying SQL patches"
for f in [0-9][0-9]*.sql; do
	echo "        on file: $f"
#	if $instance in $f; then
		sudo -u postgres psql -q $instance < "$f"
#	else
#		echo "        - skipping"
#	fi
done

echo "    clearing python bytecode"
find /var/www/$baseurl/api-data -name "*.pyc" -exec rm -rf {} \;

echo "    restating apache"
sudo service apache2 restart

echo "... twine ($instance instance) db creation script complete"
