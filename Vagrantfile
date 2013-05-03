# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.define :twine do |inv_config|
        inv_config.vm.box = "precise32"
        inv_config.vm.box_url = "http://files.vagrantup.com/precise32.box"
        inv_config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", 2048, "--cpus", 2]
        end
        inv_config.ssh.max_tries = 360
        #inv_config.vm.forward_port 80, 8081
        #inv_config.vm.forward_port 3306, 3316
        inv_config.vm.network :forwarded_port, guest: 80, host: 8081
        inv_config.vm.network :forwarded_port, guest: 3306, host: 3316
        inv_config.vm.hostname = "twine"
        
        inv_config.vm.synced_folder "../", "/var/www"

        inv_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = "twine.pp"
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
            #puppet.options = "--verbose"
        end

        inv_config.vm.provision :shell, :path => "src/sql/mysql.build.sh"
    end
end
