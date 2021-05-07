module DatacraftsIoSkeleton
  module Tools
    class AnswerCheck
      class << self
        def call(extension, answer)
          return true if extension.hidden
          return answer == true if extension.type_boolean?
          return !answer.nil?   if extension.type_array? || extension.allow_blank

          !answer.empty?
        end
      end
    end
  end
end
