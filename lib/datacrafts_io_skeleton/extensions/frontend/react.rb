# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Extensions
    module Frontend
      class React
        include Base

        use_option_name "react", aliases: :r

        use_possible_values type: :string, default: "cra-template", allow_blank: true

        use_desc "Adds React.js to your project with selected template. Check available templates at https://www.npmjs.com/search?q=cra-template-*"

        before :frontend do
          ensure_yarn_installed!
        end

        process :frontend do
          inside destination_root do
            run "yarn create react-app frontend --template #{current_answer}"
          end
        end
      end
    end
  end
end
