class etl
{
  package { "python-pip":
    ensure    => present,
    require   => [Exec['apt-get update']]
  }

  package { "python-dev":
    ensure    => present,
    require   => Exec['apt-get update']
  }

  exec { "update-pip":
    command   => "sudo pip install --upgrade pip",
    require   => [Package['python-pip']]
  }

  exec { "add-r-source":
    command => 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu precise/" >> /etc/apt/sources.list && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9',
    notify  => Exec['apt-get update']
  }

  package { "r-base":
    ensure   => present,
    require  => [Exec['apt-get update']]
  }

  exec { "install-r-packages":
    command => "R CMD BATCH /var/www/vagrant/src/scripts/R-setup.R",
    require => [Package['r-base']]
  }

  user { 'rserve':
    ensure  => present,
    gid     => 'rserve',
  }

  group { 'rserve':
    ensure  => present,
  }

  file
  {
    "/etc/init.d/rserve":
      ensure  => present,
      source  => "/var/www/vagrant/puppet/templates/rserve"
  }

  service { 'rserve':
    ensure  => running,
    enable  => true,
    require => [File["/etc/init.d/rserve"], Package['r-base'], Exec['install-r-packages']]
  }

  package { "libpq-dev":
    ensure   => present,
    require  => [Exec['apt-get update']]
  }

  exec { "python-requirements":
    command => "sudo pip install --upgrade -r /var/www/siv-v3/api-data/requirements.txt",
    timeout => 50000,
    require => [
      Package['python-dev'],
      Exec['update-pip'],
      Package['r-base'],
      Package['libpq-dev']
    ]
  }

}
