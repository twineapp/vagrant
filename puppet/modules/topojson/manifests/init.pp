class topojson
{

    exec 
    { 
        'topojson-setup':
            command => '/var/www/vagrant/src/scripts/topojson-setup.sh',
            require => Package['nodejs']
    }

}
