# -*- mode: ruby -*-


Vagrant.configure("2") do |config|
    config.vm.define :twine do |inv_config|
        inv_config.vm.box = "precise64"
        inv_config.vm.box_url = "http://files.vagrantup.com/precise64.box"
        inv_config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", 2048, "--cpus", 2]
        end

        #inv_config.vm.network :forwarded_port, guest: 80, host: 8081
        #inv_config.vm.network :forwarded_port, guest: 3306, host: 3316
        inv_config.vm.network :forwarded_port, guest: 5432, host:5432
        config.vm.network :private_network, ip: "192.168.50.4"

        inv_config.vm.hostname = "twine"

        inv_config.vm.synced_folder "../", "/var/www", :mount_options => ["dmode=777","fmode=777"], owner: "www-data", group: "www-data"

        inv_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "twine.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
            #puppet.options = "--verbose"
        end

        inv_config.vm.provision :shell, :inline => "/var/www/vagrant/src/scripts/postgres.build.sh"
        inv_config.vm.provision :shell, :inline => "/var/www/vagrant/src/scripts/locale.setup.sh"
    end
end