require "thor"

module DatacraftsIoSkeleton
  # Responsible for the creation of rails projects.
  class RailsCreator < Thor
    include Thor::Actions

    # Defines gem templates folder which you can use to load template to the new app.
    TEMPLATES_DIR = (File.dirname(__FILE__) + "/../../templates").freeze

    source_root TEMPLATES_DIR

    no_commands do
      # Creates new instance of _DatacraftsIoSkeleton::RailsCreator_ class
      # with app_name which will be used during creation.
      #
      # @param [String] app_name  The name of app you are going to create.
      def initialize(app_name)
        super()
        @app_name = app_name
      end

      # Creates new rails API app from predefined template. Copies rubocop and spec files
      # to the new project.
      def call
        create_rails_api_app
        configure_rubocop
        update_spec_config
        run_rubocop
        commit_project
      end
    end

    private

    no_commands do
      def create_rails_api_app
        run "rails new #{ @app_name } --database=postgresql --api -T -m #{ TEMPLATES_DIR }/rails.rb"
      end

      def configure_rubocop
        template "rubocop.yml.erb", app(".rubocop.yml")
      end

      def update_spec_config
        remove_file app("spec/rails_helper.rb")
        copy_file "spec.rb", app("spec/rails_helper.rb")
        empty_directory app("spec/factories")
        empty_directory app("spec/models")
        empty_directory app("spec/controllers")
      end

      def run_rubocop
        run "cd #{ app } && rubocop -a"
      end

      def commit_project
        append_to_file app(".gitignore"), "/.idea/\n"
        run "cd #{ app } && git add . && git commit -m 'Initial commit.'"
      end

      def app(path=nil)
        "#{ @app_name }/#{ path }"
      end
    end
  end
end
