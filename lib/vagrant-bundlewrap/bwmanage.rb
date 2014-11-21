module VagrantPlugins
	module BundleWrap
		class BwManage

			def initialize(repo_path)
				@repo_path = repo_path
			end

			def bw_cli(params, ret_stdout=true)
				params = params.gsub(/[^a-zA-Z0-9\-\_\.\s]/,'')
				old_path = Dir.pwd
				Dir.chdir(@repo_path)
				if ret_stdout
					result = `bw #{params}`
				else
					result = system("bw #{params}")
				end
				Dir.chdir(old_path)
				return result
			end

			def nodes()
				nodes = bw_cli("nodes")
				return nodes.split("\n")
			end

			def node_hosts()
				nodes = bw_cli("nodes --hostname")
				return nodes.split("\n")
			end

			def apply(node, interactive=false)
				node = node.gsub(/[^a-zA-Z0-9\-\_\.]/,'')
				if interactive
					return bw_cli("apply #{node} -i", ret_stdout=false)
				else
					return bw_cli("apply #{node}", ret_stdout=false)
				end
			end

		end
	end
end
