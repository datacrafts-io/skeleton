# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Extensions
    module Rails
      class Database
        include Base

        POSSIBLE_VALUES = %w[
          mysql
          postgresql
          sqlite3
          oracle
          sqlserver
          jdbcmysql
          jdbcsqlite3
          jdbcpostgresql
          jdbc
        ].freeze

        use_option_name :database, aliases: :d

        use_possible_values(
          POSSIBLE_VALUES,
          default: "postgresql",
          type: :string
        )

        use_desc "Select type of database for your app"

        before :rails do
          when_answer :postgresql, :mysql do
            Tools::Gemfiler.add("strong_migrations")
            Tools::Gemfiler.add("activerecord-clean-db-structure")
            Tools::Gemfiler.add("activerecord-safer_migrations")
          end
        end

        after :rails do
          when_answer :postgresql, :mysql do
            template "config/initializers/database_related.rb"
          end
        end
      end
    end
  end
end
