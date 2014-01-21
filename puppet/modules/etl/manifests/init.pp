class etl
{

    exec { 'install-pandas':
    	command	    => "sudo pip install pandas==0.12",
    	require	    => [Package['python-pip'], Package['build-essential'], Package['python-dev']],
			timeout     => 10000
    }

		package { "python-scipy":
			ensure      => present,
			require     => [Exec['apt-get update'], Exec['install-pandas']]
		}
	
    exec { "install-apscheduler":
        command     => "pip install apscheduler",
        require     => [Package['python-pip']] 
    }
}
