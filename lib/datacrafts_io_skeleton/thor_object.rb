# frozen_string_literal: true

module DatacraftsIoSkeleton
  class ThorObject < ::Thor
    include ::Thor::Actions
    include Helpers

    source_root Config::TEMPLATES_PATH

    attr_reader :app_name, :options

    no_commands do
      def initialize(app_name, options, destination_root: nil)
        destination_root ||= Config::DEST_PATH(app_name)

        super([app_name], options, destination_root: destination_root)

        @app_name = app_name
        @options = options
      end
    end
  end
end
