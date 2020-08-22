require "thor"
require_relative "./helpers"

module DatacraftsIoSkeleton
  # Responsible for the creation of rails projects.
  class ReactCreator < Thor
    include Helpers

    no_commands do
      def initialize(app_name)
        super()
        @app_name = app_name # We use it to commit changes.
        @front_name = "#{app_name}/frontend"
      end

      def call
        empty_directory @front_name
        inside @front_name do
          run "npx create-react-app ."
          run "npm i -s #{react_libs}"
        end
        commit("React frontend app was added.")
        say("React frontend part has built.")
      end
    end

    private

    no_commands do
      def react_libs
        %w[axios eslint stylelint prettier jest enzyme @testing-library/react msw].join(" ")
      end
    end
  end
end
