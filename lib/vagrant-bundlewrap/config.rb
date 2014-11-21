module VagrantPlugins
	module BundleWrap
    	class Config < Vagrant.plugin("2", :config)
            attr_accessor :repo_path
    		attr_accessor :node_name
    		attr_accessor :node_host
            attr_accessor :interactive


    		def initialize
                @repo_path = UNSET_VALUE
    			@node_name = UNSET_VALUE
    			@node_host = UNSET_VALUE
                @interactive = UNSET_VALUE
    		end

    		def finalize!
    			@repo_path = "bundlewrap/" if @repo_path == UNSET_VALUE
                @node_name = nil if @node_name == UNSET_VALUE
    			@node_host = nil if @node_host == UNSET_VALUE
                @interactive = false if @interactive == UNSET_VALUE
    		end

            def validate(machine)
                errors = _detected_errors

                unless File.directory?(repo_path) and File.exist?("#{repo_path}/nodes.py") and File.exist?("#{repo_path}/groups.py")
                    errors << "BundleWrap repository is missing in repo_path='#{repo_path}'.\n" +
                        "  Create a new one with 'bw repo create'."
                end

                unless @node_name
                    errors << "BundleWrap config 'node_name' is not set. Use the node name from your BundleWrap nodes.py."
                end

                unless @node_host
                    errors << "BundleWrap config 'node_host' is not set. Use the node host from your BundleWrap nodes.py.\n" +
                        "  This does not have to be a valid host name (e.g. 'node1.vm'), but it should be a unique one,\n" +
                        "  because it will be written in your ssh config file."
                end

                { "vagrant-bundlewrap" => errors }
              end
    	end
	end
end