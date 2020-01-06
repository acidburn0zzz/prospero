# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

Vagrant.configure('2') do |config|
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder '.', '/srv/prospero'

  config.vm.network :forwarded_port, guest: 5000, host: 5000

  config.vm.provision :shell,
                      privileged: false,
                      path: 'tools/dev/scripts/install-dependencies.sh'
  config.vm.provision :shell,
                      privileged: true,
                      path: 'tools/dev/scripts/setup-database.sh'
  config.vm.provision :shell,
                      privileged: false,
                      path: 'tools/dev/scripts/initialize-database.sh'

  config.vm.provider :docker do |docker|
    docker.build_dir = File.join(__dir__, 'tools', 'dev')
    docker.build_args = ['--build-arg', "VAGRANT_UID=#{Process.uid}"]
    docker.has_ssh = true
  end
end
