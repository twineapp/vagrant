class mongo 
{
    package 
    { 
        "mongodb":
            ensure  => present,
            require => Exec['apt-get update']
    }

    service 
    { 
        "mongodb":
            enable => true,
            ensure => running,
            require => Package["mongodb"],
    }

    exec { 'pecl-mongo-install':
        command => 'pecl install mongo',
        timeout => 3600,
        unless => "pecl info mongo",
        require => [ Package["make"], Package["build-essential"], Package["libpcre3-dev"], Package["php-pear"] ]
    }

    exec 
    { 
        'add-mongo-extension':
            command => 'echo "extension=mongo.so" >> /etc/php5/apache2/php.ini',
            require => Exec['pecl-mongo-install'],
    }
    
    exec
    {
        "mongorestore-his":
            command => 'mongorestore -d his /vagrant/src/mongo/his.bson',
            timeout => 3600,
            require => Package["mongodb"],
    }
    
    exec
    {
        "mongorestore-de-urban":
            command => 'mongorestore -d de_urban /vagrant/src/mongo/de_urban.bson',
            timeout => 3600,
            require => Package["mongodb"],
    }
}
