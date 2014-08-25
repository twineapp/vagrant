#!/bin/sh
echo "reconfiguring locale packages"
sudo dpkg-reconfigure locales
echo "adding locales..."
echo "French (fr_FR.UTF-8)"
sudo locale-gen fr_FR.UTF-8
echo "restarting apache"
sudo service apache2 restart