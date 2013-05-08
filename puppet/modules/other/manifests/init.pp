class other 
{
    package 
    { 
        "curl":
            ensure  => present,
            require => Exec['apt-get update']
    }

    exec { 'pecl-oauth-install':
        command => 'pecl install oauth',
        timeout => 3600,
        unless => "pecl info oauth",
        require => [ Package["make"], Package["build-essential"], Package["libpcre3-dev"], Package["php-pear"] ]
    }

    exec 
    { 
        'add-oauth-extension':
            command => 'echo "extension=oauth.so" >> /etc/php5/apache2/php.ini',
            require => Exec['pecl-oauth-install'],
    }
    
    exec 
    { 
        'etl-setup':
            command => '/var/www/vagrant/src/scripts/etl-setup.sh',
            require => Package['python-setuptools'],
            onlyif  => 'test -f /var/www/flaskapps/etl/setup.py',
    }

    package 
    { 
        "libpcre3-dev":
            ensure  => present,
            require => Exec['apt-get update']
    }

    exec
    {
        "wget-prince":
            command => 'wget http://www.princexml.com/download/prince_8.1-5_ubuntu12.04_amd64.deb -O /tmp/prince_8.1-5_ubuntu12.04_amd64.deb',
            timeout => 3600,
            creates =>  "/tmp/prince_8.1-5_ubuntu12.04_amd64.deb",
    }

    package 
    { 
        "libtiff4":
            ensure  => present,
            require => Exec['apt-get update']
    }

    package 
    { 
        "libgif4":
            ensure  => present,
            require => Exec['apt-get update']
    }

    package 
    { 
        "prince":
            provider => dpkg,
            ensure   => present,
            source   => "/tmp/prince_8.1-5_ubuntu12.04_amd64.deb",
            require => [ Package["libtiff4"], Package["libgif4"], Exec['wget-prince'] ]
    }

    package 
    { 
        "make":
            ensure  => present,
            require => Exec['apt-get update']
    }

    package 
    { 
        "build-essential":
            ensure  => present,
            require => Exec['apt-get update']
    }
    
    file 
    { 
        "/var/www/siv-v3/api/application/config/siv-local.php":
            ensure  => present,
            source  => "/var/www/vagrant/puppet/templates/siv-local.php",
            require => Package['apache2'],
    }

    file 
    { 
        "/var/www/siv-v3/app/config-local.js":
            ensure  => present,
            source  => "/var/www/vagrant/puppet/templates/config-local.js",
            require => Package['apache2'],
    }
    
    exec
    {
        "config_local.py":
            command => 'cp /var/www/vagrant/puppet/templates/config_local.py /var/www/flaskapps/etl/ETL/config_local.py',
            timeout => 3600,
            require => Exec["etl-setup"],
            onlyif  => 'test -f /var/www/flaskapps/etl/setup.py',
    }
    
    exec
    {
        "etl.wsgi":
            command => 'cp /var/www/vagrant/puppet/templates/etl.wsgi /var/www/flaskapps/etl/ETL/etl.wsgi',
            timeout => 3600,
            require => Exec["etl-setup"],
            onlyif  => 'test -f /var/www/flaskapps/etl/setup.py',
    }
    
    file 
    { 
        "/var/www/index.html":
            ensure  => present,
            source  => "/var/www/vagrant/puppet/templates/index.html",
            require => Package['apache2'],
    }
    
    file 
    { 
        "/var/www/phpinfo.php":
            ensure  => present,
            source  => "/var/www/vagrant/puppet/templates/phpinfo.php",
            require => Package['apache2'],
    }
    
    file 
    {
	"/var/www/siv-v3/filestore":
	    ensure => "directory",
	    owner  => "root",
	    group  => "root",
	    mode   => 777,
    }
}
