# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Creators
    class Base < ThorObject
      Tools = DatacraftsIoSkeleton::Tools

      source_root Config::TEMPLATES_PATH

      attr_reader :current_answer, :current_extension

      class << self
        def create(*args)
          new(*args).call
        end
      end

      no_commands do
        def call
          before_actions
          process!
          after_actions
        end

        protected

        def when_answer(*answers)
          answers.map!(&:to_s)

          yield if block_given? && correct_answer?(answers)
        end

        def before_procs
          @before_procs ||=
            ProcContainer.extract(target: target, type: :before)
        end

        def after_procs
          @after_procs ||=
            ProcContainer.extract(target: target, type: :after)
        end

        def process!; end

        def target
          raise NotImplementedError
        end

        private

        def before_actions
          run_procs(before_procs)
        end

        def after_actions
          run_procs(after_procs)
          say_status_after
        end

        def say_status_after; end

        def run_procs(procs)
          procs.each do |item|
            @current_extension = item[:extension]
            @current_answer = options[current_extension.option_name]

            instance_exec(&item[:block]) if acceptable_answer?

            @current_extension = @current_answer = nil
          end
        end

        def correct_answer?(cases)
          if current_extension.type == :array
            (current_answer & cases).any?
          else
            cases.include?(current_answer)
          end
        end

        def acceptable_answer?
          Tools::AnswerCheck.call(current_extension, current_answer)
        end
      end
    end
  end
end
