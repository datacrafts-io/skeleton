# frozen_string_literal: true

module OptionsExtractor
  class << self
    def included(klass)
      Extensions.all.each do |extension|
        kwargs = extract_option_params(extension)
        klass.public_send(:method_option, extension.option_name, **kwargs)
      end
    end

    private

    def extract_option_params(extension)
      banner = extension.type == :string ? "{#{extension.possible_values&.join(',')}}" : nil

      {
        aliases: extension.aliases,
        type: extension.type,
        desc: extension.desc,
        default: extension.default_value,
        banner: banner,
        hide: extension.hidden
      }
    end
  end
end
