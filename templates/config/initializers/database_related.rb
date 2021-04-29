# frozen_string_literal: true

ActiveRecord::Base.dump_schema_after_migration = Rails.env.development?
StrongMigrations.auto_analyze = Rails.env.development?

ActiveRecord::SaferMigrations.default_lock_timeout = 750
ActiveRecord::SaferMigrations.default_statement_timeout = 1500

Rails.application.configure do
  config.activerecord_clean_db_structure.ignore_ids = true
  config.activerecord_clean_db_structure.indexes_after_tables = true
  config.activerecord_clean_db_structure.order_column_definitions = true
  config.activerecord_clean_db_structure.order_schema_migrations_values = true
end
