Vagrant setup for Twine
=======================

Virtual OS: Ubuntu 12.04 (Precise) x86
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
2. Clone this repository/folder (twineapp/vagrant). This will be your project directory.
3. Clone / copy in the twine repos and datasets
a. Clone 'siv-v3' github repository into 'twineapp/vagrant/src/' directory (~55MB)
b. (optional) Clone 'etl' github repository into 'twineapp/vagrant/src/flaskapps/' directory and switch to the V2 branch (~0.3MB)
c. Copy twine mysql build to 'twineapp/vagrant/src/mysql' directory, don't overwrite the .sh file (~83MB)
d. (optional) Copy twine mongodb build to 'twineapp/vagrant/src/mongo' directory (~288MB)
4. Run terminal, go into your project directory 'twine vagrant', and execute the command 'vagrant up'. This will download the base box of ubuntu (~35MB), and bring up the twine vm
5. Replace the siv-local.php file at /siv-v3/api/application/config/ with the version sent by email / in the config dropbox folder

Notes:
- Server should be ready to use (webserver: 8081, mysql: 3316)
- Test via http://localhost:8081/phpinfo.php OR http://localhost:8081/siv-v3/login.php
- src in the directory is linked to the webserver document root

VM Passwords
- mysql username:password are root:password

Vagrant command reference
 - http://docs.vagrantup.com/v2/cli/index.html