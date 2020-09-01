require "thor"
require_relative "./version"
require_relative "./rails_creator"
require_relative "./react_creator"

module DatacraftsIoSkeleton
  # Defines all CLI commands, their descriptions, params and aliases.
  class Composer < Thor
    FRONTEND_CREATORS = {
      "react" => ->(app_name, options) { ReactCreator.new(app_name, options).call },
      nil => proc { |app_name| puts("The frontend is not specified for #{app_name}") }
    }.freeze
    ALLOWED_FRONTEND = FRONTEND_CREATORS.keys.freeze

    desc "create APP_NAME", "This will create new rails app."
    long_desc <<-CREATE_NEW_APP
      This command will create new rails app with configured rails_helper.rb and .rubocop.yml files. 
      All major gems are also included.

      You can use this command with next aliases:\n

       `datacrafts-io-skeleton create APPNAME`\n
       `datacrafts-io-skeleton build APPNAME`\n
       `datacrafts-io-skeleton new APPNAME`\n

      Skip boring start and let's code amazing stuff together.

    CREATE_NEW_APP
    option :frontend, type: :string, aliases: [:f], desc: <<~DESC.gsub(/\n/, "").squeeze
      Additionally creates frontend client app, you can choose one type from the list: 
      #{ALLOWED_FRONTEND.compact.join(', ')}.
    DESC
    option :typescipt, type: :boolean, aliases: [:t], desc: "Adds typescript support to frontend application."
    map %w[new build] => :create
    # Creates new app.
    #
    # @param [String] app_name  The name of app you are going to create.
    def create(app_name)
      say("The specified frontend is not allowed", :red) && return unless specified_frontend_valid?

      DatacraftsIoSkeleton::RailsCreator.new(app_name).call
      FRONTEND_CREATORS[options[:frontend]].call(app_name, options)
    end

    desc "version", "Display version"
    map %w[-v --version] => :version
    # Informs user about gem version.
    def version
      say("datacrafts-io-skeleton #{DatacraftsIoSkeleton::VERSION}")
    end

    private

    def specified_frontend_valid?
      ALLOWED_FRONTEND.include?(options[:frontend])
    end
  end
end
