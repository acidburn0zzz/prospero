# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/srv/prospero"

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :docker, images: ["postgres:10", "redis:4"] do |d|
    d.run "postgres",
      args: "-e POSTGRES_USER=prospero -e POSTGRES_PASSWORD=prospero -p 5432:5432"
    d.run "redis", args: "-p 6379:6379"
  end

  config.vm.provision :shell, privileged: true,  path: "scripts/install-prerequisites.sh"
  config.vm.provision :shell, privileged: false, path: "scripts/install-ruby.sh"
  config.vm.provision :shell, privileged: false, path: "scripts/setup-profile.sh"
  config.vm.provision :shell, privileged: false, path: "scripts/install-libraries.sh"
  config.vm.provision :shell, privileged: false, path: "scripts/init-db.sh"

  config.vm.provider :virtualbox do |vb, override|
    override.vm.box = "ubuntu/bionic64"
  end
end
