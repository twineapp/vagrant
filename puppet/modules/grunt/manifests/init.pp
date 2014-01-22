class grunt
{
    exec 
    { 
        'grunt-setup':
            command => '/var/www/vagrant/src/scripts/grunt-setup.sh',
            require => Package['nodejs']
    }

}
