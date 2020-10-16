require "thor"

module DatacraftsIoSkeleton
  # Shared logic.
  module Helpers
    # Defines gem templates folder which you can use to load template to the new app.
    TEMPLATES_DIR = "#{File.dirname(__FILE__)}/../../templates".freeze

    def self.included(klass)
      klass.class_eval do
        include Thor::Actions
      end
    end

    def commit(message, app_path=app)
      run "cd #{app_path} && git add . && git commit -m '#{message}'"
    end

    def app(path=nil)
      "#{@app_name}/#{path}"
    end
  end
end
