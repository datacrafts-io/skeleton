require "thor"
require_relative "./helpers"

module DatacraftsIoSkeleton
  # Responsible for the creation of rails projects.
  class VueCreator < Thor
    include Helpers
    source_root TEMPLATES_DIR

    no_commands do
      def initialize(app_name, _options)
        super()
        @app_name = app_name # We use it to commit changes.
        @front_name = "#{app_name}/frontend"
      end

      def call
        empty_directory @front_name
        inside @front_name do
          run "vue create ."
        end
        commit("Vue frontend app was added.")
        say("Vue frontend part has built.", :green)
      end
    end
  end
end
