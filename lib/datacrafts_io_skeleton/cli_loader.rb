# frozen_string_literal: true

require "whirly"

module DatacraftsIoSkeleton
  class CliLoader
    class << self
      def start
        return yield if Config.verbose?

        Whirly.start(spinner: "dots2", color: false) do
          yield if block_given?
        end
      end

      def status=(value)
        Whirly.status = value
      end
    end
  end
end
