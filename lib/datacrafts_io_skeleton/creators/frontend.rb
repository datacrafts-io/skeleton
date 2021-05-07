# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Creators
    class Frontend < Base
      source_root Config::TEMPLATES_PATH

      no_commands do
        protected

        def process!
          CliLoader.status = "Creating frontend application"
        end

        def target
          :frontend
        end

        def ensure_yarn_installed!
          run "which yarn || npm install --global yarn"
        end

        def say_status_after
          say "Your frontend app has been successfully created at ./#{app_name}/frontend"
        end
      end
    end
  end
end
