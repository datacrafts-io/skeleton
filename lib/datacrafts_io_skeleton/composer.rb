require "thor"
require_relative "./version"
require_relative "./rails_creator"

module DatacraftsIoSkeleton
  # Defines all CLI commands, their descriptions, params and aliases.
  class Composer < Thor
    desc "create APP_NAME", "This will create new rails app."
    long_desc <<-CREATE_NEW_APP
     This command will create new rails app with configured rails_helper.rb and .rubocop.yml files. 
     All major gems are also included.

     You can use this command with next aliases:\n

     `datacrafts-io-skeleton create APPNAME`\n
     `datacrafts-io-skeleton build APPNAME`\n
     `datacrafts-io-skeleton new APPNAME`\n
    CREATE_NEW_APP
    map %w[new build] => :create
    # Creates new app.
    #
    # @param [String] app_name  The name of app you are going to create.
    def create(app_name)
      DatacraftsIoSkeleton::RailsCreator.new(app_name).call
    end

    desc "version", "Display version"
    map %w[-v --version] => :version
    # Informs user about gem version.
    def version
      say "datacrafts-io-skeleton #{ DatacraftsIoSkeleton::VERSION }"
    end
  end
end
