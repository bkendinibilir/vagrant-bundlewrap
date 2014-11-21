require "fileutils"
require_relative "bwmanage"
require_relative "sshconf"

module VagrantPlugins
	module BundleWrap
		class Provisioner < Vagrant.plugin("2", :provisioner)

			def initialize(machine, config)
				super(machine, config)
				@logger = Log4r::Logger.new("vagrant::provisioners::bundlewrap")
			end

			def configure(root_config)
			end

			def provision
				ssh = SshConf.new
				ssh.update(config.node_host, @machine.ssh_info)
				bw = BwManage.new(config.repo_path)
				bw.apply(config.node_name, config.interactive)
			end

			def cleanup
				bw = BwManage.new(config.repo_path)
				ssh = SshConf.new
				ssh.remove_hosts(bw.node_hosts)
			end

		end
	end
end