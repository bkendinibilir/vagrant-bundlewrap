require "ssh-config"

module VagrantPlugins
  module BundleWrap
    class SshConf

      def initialize()
        touch()
        @ssh_config = ConfigFile.new
      end

      def touch()
        unless File.directory?(ENV['HOME'] + "/.ssh")
            FileUtils.mkdir_p(ENV['HOME'] + "/.ssh")
        end
        FileUtils.touch(ENV['HOME'] + "/.ssh/config")
      end

      def update(host, ssh_info)
        @ssh_config.set(host, 'HostName', ssh_info[:host])
        @ssh_config.set(host, 'Port', ssh_info[:port])
        @ssh_config.set(host, 'User', ssh_info[:username])

        ssh_keys = ssh_info[:private_key_path]
        ssh_keys.each do |ssh_key|
          @ssh_config.set(host, 'IdentityFile', ssh_key)
        end

        if ssh_info[:forward_agent]
          @ssh_config.set(host, 'ForwardAgent', 'yes')
        end

        if ssh_info[:forward_x11]
          @ssh_config.set(host, 'ForwardX11', 'yes')
        end

        if ssh_info[:proxy_command]
          @ssh_config.set(host, 'ProxyCommand', ssh_info[:proxy_command])
        end

        @ssh_config.set(host, 'UserKnownHostsFile', '/dev/null')
        @ssh_config.set(host, 'StrictHostKeyChecking', 'no')
        @ssh_config.set(host, 'PasswordAuthentication', 'no')
        @ssh_config.set(host, 'IdentitiesOnly', 'yes')
        @ssh_config.set(host, 'LogLevel', 'FATAL')

        @ssh_config.save()
      end

      def remove_host(host)
        @ssh_config.rm!(host)
      end

      def remove_hosts(hosts)
        hosts.each do |host|
          @ssh_config.rm(host)
        end
        @ssh_config.save()
      end
    end
  end
end
