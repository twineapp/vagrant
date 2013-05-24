#!/bin/sh

echo "***NOTE: this script must be run as sudo***"

apt-get install php5-xsl graphviz

pear channel-discover pear.phpdoc.org

pear install phpdoc/phpDocumentor-alpha

