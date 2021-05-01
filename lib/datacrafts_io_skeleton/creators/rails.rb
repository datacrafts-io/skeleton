# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Creators
    class Rails < Base
      source_root Config::TEMPLATES_PATH

      no_commands do
        protected

        def process!
          Whirly.status = "Creating Rails application"

          inside destination_root do
            template "rails.rb.erb", "rails.rb"

            run <<~CMD, abort_on_failure: true
              rails new . --database=#{options[:database]} --api -T -m rails.rb
            CMD

            remove_file "rails.rb"
          end
        end

        def target
          :rails
        end

        def say_status_after
          say "Your Rails app has been successfully created at ./#{app_name}"
        end
      end
    end
  end
end
