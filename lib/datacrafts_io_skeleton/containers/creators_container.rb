# frozen_string_literal: true

module DatacraftsIoSkeleton
  class CreatorsContainer < ThorObject
    source_root Config::TEMPLATES_PATH

    no_commands do
      def call
        Creators::Rails.create(app_name, options)
        Creators::Frontend.create(app_name, options)

        # Creators::Docker.create(app_name, options)
        # Creators::K8S.create(app_name, options)
        # Creators::JWT.create(app_name, options)
        # ...
        after_all_actions
      end

      private

      def after_all_actions
        Whirly.status = "Finishing..."

        ProcContainer.extract(target: :all, type: :after).each do |p|
          instance_exec(&p[:block])
        end
      end
    end
  end
end
