# frozen_string_literal: true

require "pry"
require "thor"
require "whirly"
require "datacrafts_io_skeleton/version"
require "datacrafts_io_skeleton/helpers"
require "datacrafts_io_skeleton/config"
require "datacrafts_io_skeleton/thor_object"
require "datacrafts_io_skeleton/extensions"
require "datacrafts_io_skeleton/options_extractor"

%w[containers extensions tools creators].each do |folder|
  Dir[File.join(__dir__, "datacrafts_io_skeleton", folder, "**", "*.rb")].sort.each { |f| require f }
end

# Simple gem with CLI that helps team to start new project quickly.
module DatacraftsIoSkeleton
  class Composer < ::Thor
    include OptionsExtractor
    include Helpers

    desc "create APP_NAME", "Create you own best Rails/JS app"

    def create(app_name)
      say "Skeleton in creating your best Rails/JS application \n"

      Whirly.start spinner: "bouncingBall", color_change_rate: 0, color: "blue" do
        CreatorsContainer.new(app_name, options).call
      end
    end
  end
end
