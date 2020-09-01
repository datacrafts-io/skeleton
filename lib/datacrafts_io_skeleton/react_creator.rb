require "thor"
require_relative "./helpers"

module DatacraftsIoSkeleton
  # Responsible for the creation of rails projects.
  class ReactCreator < Thor
    include Helpers
    source_root TEMPLATES_DIR

    DEFAULT_FOLDERS = %w[src/tests src/components].freeze

    no_commands do
      def initialize(app_name, options)
        super()
        @app_name = app_name # We use it to commit changes.
        @front_name = "#{app_name}/frontend"
        @ts = options[:typescipt]
      end

      def call
        empty_directory @front_name
        inside @front_name do
          create_react_app
          create_default_folders
        end
        copy_config_files
        run_linters
        commit("React frontend app was added.")
        say("React frontend part has built.", :green)
      end
    end

    private

    no_commands do
      def create_react_app
        run "npx create-react-app . #{@ts && '--template typescript'}"
        run "npm i -s #{react_libs}"
        run "npm install"
      end

      def create_default_folders
        DEFAULT_FOLDERS.each(&method(:empty_directory))
      end

      def copy_config_files
        copy_file "eslintrc.js", app("frontend/.eslintrc.js")
        copy_file "stylelintrc.json", app("frontend/.stylelintrc")
        copy_file "prettierrc.json", app("frontend/.prettierrc.json")
      end

      def run_linters
        run "cd #{app('frontend')} && npx eslint --quiet --fix --ext ts,tsx,js,jsx src"
        run "cd #{app('frontend')} && npx stylelint --fix **/*.css"
      end

      def react_libs
        %w[axios prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin
           eslint-plugin-react eslint-config-prettier eslint-plugin-prettier
           stylelint stylelint-config-standard typescript
           enzyme @testing-library/react msw].join(" ")
      end
    end
  end
end
