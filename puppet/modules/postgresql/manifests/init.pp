class postgresql
{
    $packages = [
        "postgresql-9.3-postgis",
        "pgadmin3",
        "php5-pgsql",
        "phppgadmin"
    ]

    package
    {
        $packages:
            ensure  => present,
            require => [Exec['apt-get update'], Exec['postgresql-update'], Exec['postgresql-key'], Exec['postgresql-repo']]
    }

    exec
    {
        'postgresql-update':
            command => 'update-alternatives --remove postmaster.1.gz /usr/share/postgresql/9.1/man/man1/postmaster.1.gz'
    }

    exec
    {
        'postgresql-key':
            command => 'wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -',
    }

    exec
    {
        'postgresql-repo':
            command => 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list',
            require => Exec['postgresql-key'],
            notify  => Exec['apt-get update']
    }

    exec
    {
        'postgresql-setup':
            command => 'sudo bash /var/www/vagrant/src/scripts/postgresql.setup.sh',
            require => [Package['postgresql-9.3-postgis'], Package['phppgadmin']]
    }
}