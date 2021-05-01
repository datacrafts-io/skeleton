module DatacraftsIoSkeleton
  module Tools
    class Vue
      @plugins = {}

      class << self
        attr_reader :plugins

        def add_plugin(plugin_name, options={})
          plugins["@vue/cli-plugin-#{plugin_name}"] = options
        end

        def to_config
          {
            vueVersion: "2",
            useConfigFiles: true,
            plugins: plugins
          }.to_json
        end
      end
    end
  end
end
