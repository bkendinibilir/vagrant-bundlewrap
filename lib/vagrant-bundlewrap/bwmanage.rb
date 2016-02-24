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

      def apply(node, debug=false, interactive=false)
        node = node.gsub(/[^a-zA-Z0-9\-\_\.]/,'')
        cmd = "--add-host-keys "
        if debug
          cmd = cmd + "--debug "
        end
        cmd = cmd + "apply "
        if interactive
          cmd = cmd + "--interactive "
        end
        return bw_cli(cmd + node, ret_stdout=false)
      end
    end
  end
end
