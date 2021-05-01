# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Extensions
    module Rails
      class DryInitializer
        include Base

        use_option_name "dry-initializer", aliases: :i

        use_possible_values default: true, type: :boolean

        use_desc "Adds dry-initializer to your config"

        before :rails do
          Tools::Gemfiler.add("dry-initializer")
        end

        after :rails do
          empty_directory "app/services"
          template "app/services/application_service.rb"
        end
      end
    end
  end
end
