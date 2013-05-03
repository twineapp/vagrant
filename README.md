Vagrant setup for Twine
=======================

Virtual OS: Ubuntu 12.04 (Precise) x64
With Packages:
- Apache
- MySQL
- PHP
- phpMyAdmin
- Curl
- OAuth
- Mongo
- Prince
- Python
- Flask

Requirements:
- VirtualBox (https://www.virtualbox.org/wiki/Downloads), tested with v4.2.12
- Vagrant (http://downloads.vagrantup.com), tested with v1.2.1

Guide:  
1. Download and install software from Requirements  
2. Create a folder named 'twineapp/' and clone this repository (twineapp/vagrant).  
3. Clone / copy in the twine repos and datasets  
  a. Clone 'siv-v3' github repository into 'twineapp/siv-v3/' directory (~55MB)  
  b. (optional) Clone 'etl' github repository into 'twineapp/flaskapps/etl/' directory and switch to the V2 branch (~0.3MB)  
  c. Copy twine mysql build to 'twineapp/vagrant/src/mysql' directory, don't overwrite the .sh file (~83MB)  
  d. (optional) Copy twine mongodb build to 'twineapp/vagrant/src/mongo' directory (~288MB)  
  e. (optional) Copy etl.cfg from Dropbox into /flaskapps/etl/ETL/  
4. Run terminal, go into 'twineapp/vagrant/', and execute the command 'vagrant up'. This will download the base box of ubuntu (~35MB), and bring up the twine vm  
5. Replace the siv-local.php file at /siv-v3/api/application/config/ with the version sent by email / in the config dropbox folder  

Installing Puppets Locally:  
1. Clone this repository (twineapp/vagrant) in '/var/www/'  
2. Go through step 3. from above "Guide"  
3. sudo apt-get install puppet-common  
4. Change directory to '/var/www/vagrant/' and run: sudo puppet apply puppet/manifests/twine.pp --modulepath=puppet/modules/  
5. Go through step 5. from above "Guide"  

Notes:
- Server should be ready to use (webserver: 8081, mysql: 3316)
- Test via http://localhost:8081/phpinfo.php OR http://localhost:8081/siv-v3/login.php
- src in the directory is linked to the webserver document root
- Command to copy files to Amazon EC2: scp -i ~/Desktop/ubuntu.pem sql/* ubuntu@54.243.48.252:/var/www/vagrant/src/sql

VM Passwords
- mysql username:password are root:password

Vagrant command reference
 - http://docs.vagrantup.com/v2/cli/index.html
