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

  def add(extension:, type:, target:, answers: [], &block)
    @procs << {
      extension: extension,
      target: target,
      type: type,
      answers: cast_answers(extension.type, answers),
      block: block
    }
  end

  def extract(target:, type:, options: {})
    @procs.select do |config|
      config[:target] == target &&
        config[:type] == type &&
        correct_answer?(config, options)
    end
  end

  def correct_answer?(config, options)
    answers = config[:answers]
    return true if answers.nil? || answers.none?

    answer = options[config[:extension].option_name]
    answer.nil? || answers.include?(answer)
  end

  def cast_answers(extension_type, answers)
    case extension_type
    when :boolean
      [true]
    when :string
      answers.map(&:to_s)
    else
      answers
    end
  end
end
