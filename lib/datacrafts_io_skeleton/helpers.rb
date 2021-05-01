# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Helpers
    VERBOSE = false

    def commit(message)
      run "git add . && git commit -m '#{message}'"
    end

    # add verbose: false to methods to prevent Thor print the description of them
    %i[copy_file remove_file append_to_file empty_directory template].each do |method_name|
      define_method(method_name) do |*args, **kwargs, &block|
        super(*args, verbose: VERBOSE, **kwargs, &block)
      end
    end

    def run(*args, **kwargs)
      super(*args, verbose: VERBOSE, capture: !VERBOSE, **kwargs)
    end
  end
end
