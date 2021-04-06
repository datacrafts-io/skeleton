# frozen_string_literal: true

require "pry"

require_relative "config"
require_relative "gemfiler"
require_relative "extension_base"
require_relative "extensions"
require_relative "helpers"

Dir["./containers/**/*.rb"].sort.each { |f| require f }
Dir["./extractors/**/*.rb"].sort.each { |f| require f }
Dir["./extensions/**/*.rb"].sort.each { |f| require f }
Dir["./creators/**/*.rb"].sort.each { |f| require f }

class Main < Thor
  include OptionsExtractor
  include Helpers

  desc "create", "Create you own best rails+js app"

  def create(app_name)
    CreatorsContainer.new(app_name, options).call
  end
end
