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

## Requirements:
- VirtualBox (https://www.virtualbox.org/wiki/Downloads), tested with v4.2.12
- Vagrant (http://downloads.vagrantup.com), tested with v1.2.1

## Guide:  
1. Download and install software from Requirements  
2. Create a folder named 'twineapp/' and clone this repository (twineapp/vagrant).  
3. Clone / copy in the twine repos and datasets  
    3.1. Clone 'siv-v3' github repository into 'twineapp/siv-v3/' directory (~55MB)  
    3.2. **(optional)** Clone 'etl' github repository into 'twineapp/flaskapps/etl/' directory and switch to the V2 branch (~0.3MB)  
    3.3. Copy twine mysql build to 'twineapp/vagrant/src/mysql/' directory (~83MB)  
    3.4. **(optional)** Copy twine mongodb build to 'twineapp/vagrant/src/mongo/' directory (~288MB)  
    3.5. **(optional)** Copy config\_local.py from Dropbox/Webhis Config into "twineapp/flaskapps/etl/ETL/"
4. Run terminal, go into 'twineapp/vagrant/', and execute the command 'vagrant up'. This will download the base box of ubuntu (~35MB), and bring up the twine vm  

## Working with the twine vagrant:
- "vagrant suspend" suspends the vm, this is normally how you would end your work session
- "vagrant halt" shuts down the vm, you would do this to autoload additional db patches for example
- "vagrant destroy" completely removes the vm from your machine. You would do this to save disk space if you won't be working on twine for a while, or to do a full rebuild after significant changes to the vagrant config


## Notes:
- Server should be ready to use at 192.168.50.4 (modify this static IP in Vagrantfile before bringing up the vagrant if required)
- Test via http://192.168.50.4/phpinfo.php OR http://192.168.50.4/siv-v3/login.php
- src in the directory is linked to the webserver document root
- Command to copy files to Amazon EC2: scp -i ~/Desktop/ubuntu.pem sql/\* ubuntu@54.243.48.252:/var/www/vagrant/src/sql

## Docs:
- To setup phpdoc and dependencies run: sudo /var/www/vagrant/src/scripts/phpdoc-setup.sh
- To generate autodocs for the Twine API run: /var/www/vagrant/src/scripts/phpdoc-build.sh
- Docs available at: http://192.168.50.4/siv-v3/docs/

## VM Passwords
- mysql username:password are root:password
- rockmongo username:password are admin:admin

## Vagrant command reference
 - http://docs.vagrantup.com/v2/cli/index.html

## Installing Puppets Locally:  
1. Clone this repository (twineapp/vagrant) in '/var/www/'  
2. Go through step 3. from above "Guide"  
3. sudo apt-get install puppet-common  
4. Change directory to '/var/www/vagrant/' and run: sudo puppet apply puppet/manifests/twine.pp --modulepath=puppet/modules/  
