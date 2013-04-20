class python 
{      
    $packages = [
        "python", 
        "python-dev", 
        "python-pip", 
        "python-numpy",
        "python-mysqldb",
        "libmysqlclient-dev"
    ]
    
    package 
    { 
        $packages:
            ensure  => present,
            require => Exec['apt-get update']
    }
    
    exec { 'pip-install-flask':
        command => 'pip install flask',
        timeout => 3600,
        require => [ Package["python"], Package["python-pip"] ]
    }

    exec { 'pip-install-pymongo':
        command => 'pip install pymongo',
        timeout => 3600,
        require => [ Package["python"], Package["python-pip"] ]
    }
}
