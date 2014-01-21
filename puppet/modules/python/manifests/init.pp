class python 
{      

    package { 'python':
	ensure	    => present,
	require	    => Exec['apt-get update'] 
    }
    
    package { 'python-pip':
			ensure	    => present,
			require	    => Exec['apt-get update'] 
    }
    
    package { 'python-setuptools':
			ensure	    => present,
			require	    => Exec['apt-get update'] 
    }

		package { "python-dev":
			ensure      => present,
			require     => [Exec['apt-get update']]
		}

}
