# Default path
Exec 
{
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

exec 
{ 
    'apt-get update':
        command => '/usr/bin/apt-get update'
}

include bootstrap
include other
include apache
include php
include postgresql
include mysql
include phpmyadmin
include mongo
include python
include nodejs
include grunt
include etl
include wsgi
include twine

exec 
{ 
    'service apache2 reload':
        command => 'service apache2 reload',
        require => [ Exec["add-oauth-extension"], Exec["add-mongo-extension"] ]
}
