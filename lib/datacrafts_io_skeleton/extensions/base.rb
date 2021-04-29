# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Extensions
    module Base
      module ClassMethods
        attr_reader :hidden, :default_value, :type, :desc, :option_name, :aliases, :possible_values

        def set_default_variables
          @hidden = false
          @default_value = nil
          @type = :string
          @desc = nil
          @option_name = nil
          @aliases = nil
        end

        def hide_from_options!
          @hidden = true
          @option_name = "hidden"
        end

        def use_option_name(name, aliases: [])
          @option_name = name.to_s
          @aliases = aliases.is_a?(Array) ? aliases : [aliases]
        end

        def use_possible_values(values=nil, type:, default: nil)
          @possible_values = values
          @default_value = type == :string ? default.to_s : default
          @type = type
        end

        def use_desc(text)
          @desc = text
        end

        def before(target, &block)
          ProcContainer.add(extension: self, type: :before, target: target, &block)
        end

        def after(target, &block)
          ProcContainer.add(extension: self, type: :after, target: target, &block)
        end

        alias process after
      end

      def self.included(klass)
        klass.send(:extend, ClassMethods)
        klass.send(:set_default_variables)
      end
    end
  end
end
