# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Creators
    class Rails < Base
      source_root "#{Config::ROOT_PATH}/templates"

      no_commands do
        def process!
          inside destination_root do
            template "rails.rb.erb", "rails.rb"

            run <<~CMD, abort_on_failure: true
              rails new . --database=#{options[:database]} --api -T -m rails.rb
            CMD

            remove_file "rails.rb"
          end
        end

        private

        def target
          :rails
        end
      end
    end
  end
end
