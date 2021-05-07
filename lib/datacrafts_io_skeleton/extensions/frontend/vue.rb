# frozen_string_literal: true

require "json"

module DatacraftsIoSkeleton
  module Extensions
    module Frontend
      class Vue
        include Base

        use_option_name "vue", aliases: :v

        use_possible_values %i[typescript eslint router pwa vuex jest], default: [], type: :array

        use_desc "Adds Vue.js to your project"

        before :frontend do
          ensure_yarn_installed!
        end

        process :frontend do
          run "yarn global add @vue/cli"

          when_answer :jest do
            Tools::Vue.add_plugin("unit-jest")
          end
          when_answer :pwa do
            Tools::Vue.add_plugin("pwa")
          end
          when_answer :vuex do
            Tools::Vue.add_plugin("vuex")
          end
          when_answer :typescript do
            Tools::Vue.add_plugin("typescript", classComponent: true, useTsWithBabel: true)
          end
          when_answer :router do
            Tools::Vue.add_plugin("router", historyMode: true)
          end
          when_answer :eslint do
            Tools::Vue.add_plugin("eslint", config: "standard", lintOn: ["save"])
          end

          inside destination_root do
            run <<~CMD
              vue create frontend -i '#{Tools::Vue.to_config}'
            CMD
          end
        end
      end
    end
  end
end
