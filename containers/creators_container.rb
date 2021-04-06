# frozen_string_literal: true

class CreatorsContainer < Thor
  include Thor::Actions
  include Helpers

  source_root "#{Config::ROOT_PATH}/templates"

  attr_reader :app_name, :options

  no_commands do
    def initialize(app_name, options)
      super([], {}, destination_root: "#{Config::ROOT_PATH}/#{app_name}")

      @app_name = app_name
      @options = options
    end

    def call
      Creators::Rails.create(app_name, options)
      # Creators::Frontend.create(app_name, options)
      # Creators::Docker.create(app_name, options)
      # Creators::K8S.create(app_name, options)
      # Creators::JWT.create(app_name, options)
      # ...
      after_all_actions
    end

    private

    def after_all_actions
      ProcContainer.extract(target: :all, type: :after).each do |p|
        instance_exec(&p[:block])
      end
    end
  end
end
