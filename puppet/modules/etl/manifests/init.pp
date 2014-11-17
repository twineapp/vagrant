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

		package { "r-base":
			ensure   => present,
			require  => [Exec['apt-get update']]
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
