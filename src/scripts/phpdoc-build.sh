#!/bin/sh

cd /var/www/siv-v3/

phpdoc -t docs --template responsive --directory api/ --ignore api/application/third_party/ --title "Twine docs"

