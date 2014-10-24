class etl
{

		exec { "install-flask":
			command    => "sudo pip install --upgrade flask",
			require    => [Package['python-pip']],
		}

		exec { "install-pymongo":
			command    => "sudo pip install --upgrade pymongo",
			require    => [Package["python-pip"]]
		}

    exec { "install-apscheduler":
        command     => "pip install --upgrade apscheduler==2.1.2",
        require     => [Package['python-pip']]
    }

		exec { "install-pandas":
			command       => "sudo pip install --upgrade pandas",
			timeout       => 30000,
			require       => Package['python-software-properties']
		}

		exec { "install-isoweek":
			command       => "sudo pip install --upgrade isoweek",
			require       => Package['python-pip']
		}

		package { "libpq-dev":
			ensure        => present,
			require		   => [Exec['apt-get update']]
		}

		exec { "install-psycopg2":
			command       => "sudo pip install --upgrade psycopg2",
			require       => [Package['libpq-dev']]
		}

		exec { "install-jsonschema":
			command        => "sudo pip install --upgrade jsonschema",
			require        => [Package['python-pip']]
		}

		exec { "install-babel":
			command        => "sudo pip install --upgrade babel",
			require        => [Package['python-pip']]
		}

		exec { "install-flask-babel":
			command        => "sudo pip install --upgrade flask-babel",
			require        => [Package['python-pip']]
		}

}
