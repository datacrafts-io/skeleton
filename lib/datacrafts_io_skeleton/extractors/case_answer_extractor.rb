# frozen_string_literal: true

module DatacraftsIoSkeleton
  class CaseAnswerExtractor
    class << self
      def call(extension, answers, &block)
        instance = new
        instance.instance_exec(&block)
        instance.procs.each do |config|
          save_proc(extension, answers, config)
        end
      end

      private

      def save_proc(extension, answers, config)
        ProcContainer.add(
          extension: extension,
          type: config[:type],
          target: config[:target],
          answers: answers,
          &config[:block]
        )
      end
    end

    def initialize
      @procs = []
    end

    attr_reader :procs

    def before(target, &block)
      procs.push({ type: :before, target: target, block: block })
    end

    def after(target, &block)
      procs.push({ type: :after, target: target, block: block })
    end
  end
end
