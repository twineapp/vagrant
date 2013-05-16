#!/bin/sh

echo "change directory to /var/www/vagrant/src/sql/"
cd /var/www/vagrant/src/sql/

echo "siv db script start."

echo "... 1 users"
mysql -u root -ppassword --default_character_set utf8 < siv.dbusers.sql
echo "... 2 app tables"
mysql -u root -ppassword --default_character_set utf8 < siv_app.sql
echo "... 3 data tables"
mysql -u root -ppassword --default_character_set utf8 < siv_app.data.sql
echo "... 4 user tables"
mysql -u root -ppassword --default_character_set utf8 < siv_data.sql
echo "... 5 app data"
mysql -u root -ppassword --default_character_set utf8 < siv_data.data.sql
echo "... 6 data data"
mysql -u root -ppassword --default_character_set utf8 < siv_users.sql
echo "... 7 users data"
mysql -u root -ppassword --default_character_set utf8 < siv_users.data.sql
echo "siv db script complete."

echo "Checking for and applying additional db patches automatically."

if [ -f "/var/www/vagrant/src/sql/mysql.patch.sh" ]
then
/var/www/vagrant/src/sql/mysql.patch.sh
echo "Auto patch script execution completed."
else
echo "Could not apply patches automatically, please do so manually."
fi
