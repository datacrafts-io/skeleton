# frozen_string_literal: true

require "pry"
require "thor"

require "datacrafts_io_skeleton/version"
require "datacrafts_io_skeleton/helpers"
require "datacrafts_io_skeleton/cli_loader"
require "datacrafts_io_skeleton/config"
require "datacrafts_io_skeleton/thor_object"
require "datacrafts_io_skeleton/options_extractor"

%w[containers extensions tools creators].each do |folder|
  Dir[File.join(__dir__, "datacrafts_io_skeleton", folder, "**", "*.rb")].sort.each { |f| require f }
end

# Simple gem with CLI that helps team to start new project quickly.
module DatacraftsIoSkeleton
  class Composer < ::Thor
    include OptionsExtractor
    include Helpers

    desc "create APP_NAME", <<~DESC
      Create your own best Rails/JS app.
      If you have some issues with creation please use VERBOSE=true
    DESC

    def create(app_name)
      say <<~DESC
        Skeleton in creating your best Rails/JS application.
        If you have some issues with creation please use VERBOSE=true
      DESC

      CliLoader.start do
        CreatorsContainer.new(app_name, options).call
      end
    end
  end
end
