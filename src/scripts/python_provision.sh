sudo add-apt-repository ppa:pythonxy/pythonxy-devel > /dev/null
sudo apt-get -q update > /dev/null
sudo apt-get install -y -q python-pandas
sudo apt-get install -y -q libpq-dev
sudo pip install psycopg2
sudo service apache2 restart > /dev/null
