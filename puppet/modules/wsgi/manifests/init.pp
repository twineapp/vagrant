class wsgi 
{      
    package 
    { 
        "libapache2-mod-wsgi":
            ensure  => present,
            require => Exec['apt-get update']
    }

    file 
    { 
        "/etc/apache2/mods-enabled/wsgi.load":
            ensure  => link,
            target  => "/etc/apache2/mods-available/wsgi.load",
            require => Package['libapache2-mod-wsgi'],
    }
}
