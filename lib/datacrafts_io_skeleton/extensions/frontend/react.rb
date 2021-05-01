# frozen_string_literal: true

require "json"

module DatacraftsIoSkeleton
  module Extensions
    module Frontend
      class React
        include Base

        use_option_name "react", aliases: :r

        use_possible_values %i[typescript], default: nil, type: :array

        use_desc "Adds React.js to your project"

        before :frontend do
          ensure_yarn_installed!
        end

        process :frontend do
          when_answer :typescript do
            Tools::React.add_plugin("typescript")
          end

          inside destination_root do
            run "yarn create react-app frontend #{Tools::React.to_config}"
          end
        end
      end
    end
  end
end
