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

# This needs to be done before anything else in order to ensure
# that subsequent package installs are configured for language correctly
exec { "dpkg-locales":
    command => "sudo dpkg-reconfigure locales"
}

# puppet does a check to see if the first item in a command maps to an actual executable, if it doesn't
# it will throw an error, for is a language construct and not a binary so it will fail unless there is something
# before it which evalutes to an executable, we get aroudn this by calling cat "" (a useless function) so that the rest
# of the command gets passed to the shell and executed
exec { 'locale-gen':
    command => 'sudo locale-gen fr_FR.UTF-8; sudo locale-gen en_US.UTF-8; sudo locale-gen de_DE.UTF-8; sudo locale-gen pt_BR.ISO-8859-1; sudo locale-gen es_ES.UTF-8;',
    require => [Exec['dpkg-locales']]
}


exec { 'install-gettext':
    command => 'sudo apt-get install -y gettext',
    require => [Exec['locale-gen']]
}


include bootstrap
include other
include apache
include php
include postgresql
#include mysql
#include phpmyadmin
include mongo
include python
include nodejs
include grunt
include topojson
include wsgi
include twine
include etl

exec
{
    'service apache2 reload':
        command => 'service apache2 reload',
        require => [ Exec["add-oauth-extension"], Exec["add-mongo-extension"], Exec['install-gettext'] ]
}
