gem "dry-initializer"
gem "rake-task-migration"
gem "timecop"
gem "sidekiq"

gem_group :development do
  gem "annotate"
  gem "brakeman"
  gem "bullet"
  gem "bundle-audit"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rails_best_practices"
  gem "reek"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-faker"
end

gem_group :development, :test do
  gem "faker"
  gem "rspec"
  gem "rspec-rails"
  gem "rubocop-rspec", require: false
  gem "dotenv-rails"
  gem "webmock"
end

gem_group :test do
  gem "database_cleaner-active_record"
  gem "factory_bot"
  gem "simplecov", require: false
  gem "shoulda-matchers"
end

uncomment_lines "Gemfile", "rack-cors"

run "bundle install"

rails_command "generate rspec:install"

run "bundle exec rake task_migration:install:migrations"

rails_command "db:create"
rails_command "db:migrate"
