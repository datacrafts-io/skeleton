# frozen_string_literal: true

module Extensions
  module Rails
    class Database
      include ExtensionBase

      use_option_name :database, aliases: :d

      use_possible_values(
        %i[mysql postgresql sqlite3 oracle sqlserver jdbcmysql jdbcsqlite3 jdbcpostgresql jdbc],
        default: :postgresql,
        type: :string
      )

      use_desc "Select type of database for your app"

      case_answer :postgresql, :mysql do
        before :rails do
          Gemfiler.add("strong_migrations")
          Gemfiler.add("activerecord-clean-db-structure")
          Gemfiler.add("activerecord-safer_migrations")
        end

        after :rails do
          template "config/initializers/database_related.rb"
        end
      end
    end
  end
end
