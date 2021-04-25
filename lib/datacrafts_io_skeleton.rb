# frozen_string_literal: true

require "datacrafts_io_skeleton/version"
require "datacrafts_io_skeleton/config"
require "datacrafts_io_skeleton/gemfiler"
require "datacrafts_io_skeleton/extension_base"
require "datacrafts_io_skeleton/extensions"
require "datacrafts_io_skeleton/helpers"
require "thor"

%w[containers extractors extensions creators].each do |folder|
  Dir[File.join(__dir__, "datacrafts_io_skeleton", folder, "**", "*.rb")].sort.each { |f| require f }
end

# Simple gem with CLI that helps team to start new project quickly.
module DatacraftsIoSkeleton
  class Composer < ::Thor
    include OptionsExtractor
    include Helpers

    desc "create", "Create you own best rails+js app"
    def create(app_name)
      CreatorsContainer.new(app_name, options).call
    end
  end
end
