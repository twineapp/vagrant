class twine
{

  file { "/etc/apache2/sites-available/default":
      ensure  => present,
      source  => "/var/www/vagrant/puppet/templates/vhost",
      require => [ Package["apache2"], File["/etc/apache2/mods-enabled/wsgi.load"] ]
  }

  exec { "mongorestore-his":
      command => 'mongorestore --drop -d siv /var/www/vagrant/src/mongo/his.bson',
      timeout => 3600,
      require => Package["mongodb-10gen"],
      onlyif  => 'test -f /var/www/vagrant/src/mongo/his.bson',
  }

  exec { "mongorestore-de-urban":
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


  exec { "setup-twine-tools":
    command => 'sudo ln -sf /var/www/vagrant/src/scripts/twine-tools /usr/bin/twine-tools'
  }

  file { "/var/www/siv-v3/siv.ini":
      ensure  => present,
      source  => "/var/www/vagrant/puppet/templates/siv.ini",
      require => Package['apache2'],
  }

  file { "/var/www/siv-v3/app/config.json":
      ensure  => present,
      source  => "/var/www/vagrant/puppet/templates/config.json",
      require => Package['apache2'],
  }

  file { "/var/www/siv-v3/filestore":
      ensure => "directory",
      owner  => "root",
      group  => "root",
      mode   => 777,
  }

  file { "/home/TwineHeadlessBrowser":
      ensure  => present,
      source  => "/var/www/vagrant/puppet/templates/TwineHeadlessBrowser",
      group   => "root",
      owner   => "root",
      mode    => 777
  }


}
