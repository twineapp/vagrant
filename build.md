Vagrant Builds for Twine
========================

## Load instance specific files to dev folder structure
- cd /var/www/siv-v3/
- grunt dev  --instance=/var/www/twine_instances/instancename

## Changing to prod environment:
- cd /var/www/siv-v3/
- grunt prod --twine=3-xx --instance=/var/www/twine_instances/instancename
- see twine prod version 3-21 at http://192.168.50.4/siv-v3/build-v3-xx/login.php

