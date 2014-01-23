class etl
{

		exec { "install-numpy": 
			command    => "sudo pip install numpy",
			require    => [Package["python-pip"], Package['build-essential'], Package['python-dev']],
			timeout    => 5000
		}

    exec { 'install-pandas':
    	command	    => "sudo pip install pandas==0.12",
    	require	    => [Package['python-pip'], Package['build-essential'], Package['python-dev']],
			timeout     => 10000
    }

		exec { "install-flask":
			command    => "sudo pip install flask",
			require    => [Package['python-pip']],
		}

		exec { "install-pymongo":
			command    => "sudo pip install pymongo",
			require    => [Package["python-pip"]]
		}

		exec { "install-mysql-connector":
			command    => "sudo pip install mysql-connector-python",
			require    => [Package["python-pip"]]
		}
	
    exec { "install-apscheduler":
        command     => "pip install apscheduler",
        require     => [Package['python-pip']] 
    }
		
		/* Uncomment and remove "install-mysql-connector" once postgres migration complete
		exec { "install-psycopg2":
			command    => "sudo pip install psycopg2",
			require    => [Package["build-essential"], Package["python-dev"], Package['python-pip']]
		}
		*/
}
