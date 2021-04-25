# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Helpers
    def app(path = nil)
      "#{app_name}/#{path}"
    end

    def commit(message)
      run "git add . && git commit -m '#{message}'"
    end
  end
end
