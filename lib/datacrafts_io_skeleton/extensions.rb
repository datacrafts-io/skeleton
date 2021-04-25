# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Extensions
    class << self
      def all
        @all ||= extract_extensions_recursive(Extensions)
      end

      private

      def extract_extensions_recursive(klass, acc = [])
        klass.constants(false).each do |name|
          ext = klass.const_get(name)
          if ext.instance_of?(Module)
            extract_extensions_recursive(ext, acc)
          else
            acc << ext
          end
        end
        acc
      end
    end
  end
end
