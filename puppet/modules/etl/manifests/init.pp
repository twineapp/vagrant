class etl
{

    exec { 'install-pandas':
	command	    => "pip install pandas",
	require	    => [Package['python-scipy'], Package['python-numpy'], Package['python-pip']]
    }

    exec { 'install-patsy':
	command	    => "pip install patsy",
	require	    => [Package['python-scipy'], Package['python-numpy'], Package['python-pip'], Exec['install-pandas']]    
    }

    exec { "install-statsmodels":
	command	    => "pip install statsmodels",
	require	    => [Package['python-scipy'], Package['python-numpy'], Package['python-pip'], Exec['install-patsy']]    
    }

    exec {"install-msgpack_python":
	command	    => "pip install msgpack_python",
	require	    => [Package['python-scipy'], Package['python-numpy'], Package['python-pip'], Exec['install-statsmodels']] 
     }
}
