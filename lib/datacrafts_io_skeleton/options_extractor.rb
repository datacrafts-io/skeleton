# frozen_string_literal: true

module DatacraftsIoSkeleton
  module OptionsExtractor
    class << self
      def included(klass)
        Extensions.all.each do |extension|
          kwargs = extract_option_params(extension)
          klass.method_option(extension.option_name, **kwargs)
        end
      end

      private

      def extract_option_params(extension)
        {
          enum: extension.possible_values,
          aliases: extension.aliases,
          type: extension.type,
          desc: extension.desc,
          default: extension.default_value,
          hide: extension.hidden,
          lazy_default: extension.type == :array ? extension.default_value : nil
        }
      end
    end
  end
end
