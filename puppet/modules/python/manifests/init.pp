class python 
{      
    $packages = [
        "python",
        "python-pip", 
        "python-setuptools"
    ]
    
    package 
    { 
        $packages:
            ensure  => present,
            require => Exec['apt-get update']
    }
}
