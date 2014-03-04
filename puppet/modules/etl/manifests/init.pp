class etl
{

		exec { "install-flask":
			command    => "sudo pip install flask",
			require    => [Package['python-pip']],
		}

		exec { "install-pymongo":
			command    => "sudo pip install pymongo",
			require    => [Package["python-pip"]]
		}
	
    exec { "install-apscheduler":
        command     => "pip install apscheduler",
        require     => [Package['python-pip']] 
    }

		exec { "add-pandas-repo":
			command       => "sudo add-apt-repository ppa:pythonxy/pythonxy-devel",
			require       => Package['python-software-properties']
		}

		exec { 'update-after-pandas':
			command       => "sudo apt-get update",
			require       => Exec['add-pandas-repo']
		}

		package { "python-pandas":
			ensure       => present,
			require       => [Exec["update-after-pandas"]]
		}

		package { "libpq-dev":
			ensure        => present,
			require       => Exec['update-after-pandas']			
		}

		exec { "install-psycopg2":
			command       => "sudo pip install psycopg2",
			require       => [Exec['update-after-pandas'], Package['libpq-dev']]
		}

}
