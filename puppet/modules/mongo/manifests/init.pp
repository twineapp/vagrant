class mongo 
{
    exec 
    { 
        'mongo-10gen-key':
            command => 'apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10',
    }
    
    exec 
    { 
        '10gen-repo':
            command => 'echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" > /etc/apt/sources.list.d/10gen.list',
            require => Exec['mongo-10gen-key'],
            notify  => Exec['apt-get update']
    }
    
    package 
    { 
        "mongodb-10gen":
            ensure  => present,
            require => [ Exec['apt-get update'], Exec['10gen-repo'] ],
    }

    service 
    { 
        "mongodb":
            enable => true,
            ensure => running,
            require => Package["mongodb-10gen"],
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
            command => 'mongorestore --drop -d siv /var/www/vagrant/src/mongo/his.bson',
            timeout => 3600,
            require => Package["mongodb-10gen"],
            onlyif  => 'test -f /var/www/vagrant/src/mongo/his.bson',
    }
    
    exec
    {
        "mongorestore-de-urban":
            command => 'mongorestore --drop -d siv /var/www/vagrant/src/mongo/de_urban.bson',
            timeout => 3600,
            require => Package["mongodb-10gen"],
            onlyif  => 'test -f /var/www/vagrant/src/mongo/de_urban.bson',
    }
    
    /*
    exec
    {
        "mongorestore-de-foodaid":
            command => 'mongorestore --drop -d siv /var/www/vagrant/src/mongo/de_foodaid.bson',
            timeout => 3600,
            require => Package["mongodb-10gen"],
            onlyif  => 'test -f /var/www/vagrant/src/mongo/de_foodaid.bson',
    }
    */
    exec
    {
        "wget-rockmongo":
            command => 'wget http://rockmongo.com/release/rockmongo-1.1.5.zip -O /tmp/rockmongo-1.1.5.zip',
            timeout => 3600,
            creates =>  "/tmp/rockmongo-1.1.5.zip",
    }
    
    package 
    { 
        "unzip":
            ensure  => present,
            require => Exec['apt-get update']
    }
    
    exec
    {
        "unzip-rockmongo":
            command => 'unzip -o /tmp/rockmongo-1.1.5.zip -d /var/www/',
            timeout => 3600,
            require => [ Exec['wget-rockmongo'], Package["unzip"] ]
    }
}
