module DatacraftsIoSkeleton
  module Tools
    class React
      @plugins = { "@vue/cli-plugin-babel" => {} }

      class << self
        attr_reader :plugins

        def add_plugin(plugin_name, options={})
          plugins[plugin_name] = options
        end

        def to_config
          plugins.map { |k, v| "--#{k} #{v}" }.join(" ")
        end
      end
    end
  end
end
