require "vagrant"

module VagrantPlugins
	module BundleWrap
		class Plugin < Vagrant.plugin("2")
  			name "vagrant-bundlewrap"

			config(:bundlewrap, :provisioner) do
				require_relative "config"
				Config
			end

  			provisioner(:bundlewrap) do
  				require_relative "provisioner"
    			Provisioner
  			end
  		end
  	end
end
