module DatacraftsIoSkeleton
  class ProcContainer
    class << self
      def instance
        @instance ||= new
      end

      def add(**kwargs, &block)
        instance.send(:add, **kwargs, &block)
      end

      def extract(**kwargs, &block)
        instance.send(:extract, **kwargs, &block)
      end
    end

    def initialize
      @procs = []
    end

    private

    def add(extension:, type:, target:, &block)
      @procs << {
        extension: extension,
        target: target,
        type: type,
        block: block
      }
    end

    def extract(target:, type:)
      @procs.select do |config|
        config[:target] == target &&
          config[:type] == type
      end
    end
  end
end
