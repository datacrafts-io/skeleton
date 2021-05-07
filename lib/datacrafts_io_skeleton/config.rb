# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Config
    ROOT_PATH = File.expand_path(File.join(__dir__, "..", ".."))

    TEMPLATES_PATH = "#{ROOT_PATH}/templates"

    class << self
      def DEST_PATH(app_name) # rubocop:disable Naming/MethodName
        File.join(File.expand_path(Dir.pwd), app_name)
      end

      def verbose?
        ENV.key?("VERBOSE")
      end
    end
  end
end
