Vagrant setup for Twine
=======================

Virtual OS: Ubuntu 12.04 (Precise) x64
With Packages:
- Apache
- MySQL
- PostgreSQL
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
    3.2. **(optional)** Clone 'api-data' github repository into 'twineapp/siv-v3/api-data/' directory (~0.3MB)  
    3.3. **(optional)** Clone 'documentation' github repository into 'twineapp/documentation/' directory  
    3.4. Copy twine mysql build to 'twineapp/vagrant/src/mysql/' directory (~83MB)  
    3.5. **(optional)** Copy twine mongodb build to 'twineapp/vagrant/src/mongo/' directory (~288MB)
4. Run terminal, go into 'twineapp/vagrant/', and execute the command 'vagrant up'. This will download the base box of ubuntu (~35MB), and bring up the twine vm  

## Working with the twine vagrant:
- "vagrant up" starts the virtual machine
- "vagrant suspend" suspends the vm, this is normally how you would end your work session
- "vagrant halt" shuts down the vm, you would do this to autoload additional db patches for example
- "vagrant reload" is equivelent to a halt and up, and should be run after changes to the vagrant repo. Before a reload, delete the siv_% dbs (you can run siv.drop.sql in phpmyadmin to do this)
- "vagrant destroy" completely removes the vm from your machine. You would do this to save disk space if you won't be working on twine for a while, or to do a full rebuild after significant changes to the vagrant repo
- command reference: http://docs.vagrantup.com/v2/cli/index.html


## Notes:
- Server should be ready to use at 192.168.50.4 (modify this static IP in Vagrantfile before bringing up the vagrant if required)
- Test via http://192.168.50.4/phpinfo.php OR http://192.168.50.4/siv-v3/login.php
- src in the directory is linked to the webserver document root
- Command to copy files to Amazon EC2: scp -i ~/Desktop/ubuntu.pem sql/\* ubuntu@54.243.48.252:/var/www/vagrant/src/sql

## PHP Docs:
- To setup phpdoc and dependencies run: sudo /var/www/vagrant/src/scripts/phpdoc-setup.sh
- To generate autodocs for the Twine API run: /var/www/vagrant/src/scripts/phpdoc-build.sh
- Docs available at: http://192.168.50.4/siv-v3/docs/
- these are copied into the documentation repo at documentation/api/app/

## VM Passwords
- mysql username:password are root:pwd
- rockmongo username:password are admin:admin
- postgresql username:password are admin:pwd

## VM URLs
- http://192.168.50.4/phpmyadmin
- http://192.168.50.4/rockmongo
- http://192.168.50.4/phppgadmin

## Known issues
- **Hardware virtualization.** Issues have been reported in Windows 7 when hardward virtualization was not enabled in the system bios. http://www.virtualbox.org/manual/ch10.html
- **Python install in Windows hosts.** The etl-setup.sh script is not executing in windows hosts. To run in manually:
    - bring up the vagrant
    - ssh in
    - $ cd /var/www/flaskapps/etl/
    - $ sudo python setup.py install
    - in your host, copy twineapp/vagrant/puppet/templates/config_local.py to twineapp/flaskapps/etl/ETL/config_local.py
    - $ sudo apachectl restart
    - You should now get a response at 192.168.50.4/etl/status

## Installing Puppets Locally:  
1. Clone this repository (twineapp/vagrant) in '/var/www/'  
2. Go through step 3. from above "Guide"  
3. sudo apt-get install puppet-common  
4. Change directory to '/var/www/vagrant/' and run: sudo puppet apply puppet/manifests/twine.pp --modulepath=puppet/modules/  
