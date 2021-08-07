# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Extensions
    class Docker
      include Base

      use_option_name "dockerize", aliases: :c

      use_possible_values type: :boolean, default: false

      use_desc "Wraps your application to docker containers w/ docker-compose"

      after :all do
        inside destination_root do
          directory "docker"

          template "docker-compose.yml"
          template "docker-compose.development.yml"
          template "docker-compose.development.yml", "docker-compose.override.yml"

          append_to_file ".gitignore", "/.docker-compose.override.yml"
        end
      end
    end
  end
end
