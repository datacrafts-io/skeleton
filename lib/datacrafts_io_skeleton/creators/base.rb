# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Creators
    class Base < ::Thor
      include ::Thor::Actions
      include Helpers

      source_root "#{Config::ROOT_PATH}/templates"

      attr_reader :app_name, :options, :before_procs, :after_procs, :target

      class << self
        def create(*args)
          instance = new(*args)
          instance.before_actions
          instance.process!
          instance.after_actions
        end
      end

      no_commands do
        def initialize(app_name, options)
          super([], {}, destination_root: app_name)

          @app_name = app_name
          @options = options
          @before_procs = ProcContainer.extract(target: target, type: :before, options: options)
          @after_procs = ProcContainer.extract(target: target, type: :after, options: options)
        end

        def before_actions
          run_procs(before_procs)
        end

        def after_actions
          run_procs(after_procs)
        end

        def process!
          raise NotImplementedError
        end

        def target
          raise NotImplementedError
        end

        private

        def run_procs(procs)
          procs.each do |item|
            instance_exec(&item[:block])
          end
        end
      end
    end
  end
end
