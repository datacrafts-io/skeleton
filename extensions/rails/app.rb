# frozen_string_literal: true

module Extensions
  module Rails
    class App
      include ExtensionBase

      hide_from_options!

      before :rails do
        Gemfiler.add("rubocop", group: :development, required: false)
        Gemfiler.add("rubocop-performance", group: :development, required: false)
        Gemfiler.add("rubocop-rails", group: :development, required: false)
        Gemfiler.add("rubocop-faker", group: :development, required: false)

        Gemfiler.add("faker", group: :development_test)
        Gemfiler.add("rspec", group: :development_test)
        Gemfiler.add("rspec-rails", group: :development_test)
        Gemfiler.add("rubocop-rspec", group: :development_test, required: false)

        Gemfiler.add("database_cleaner-active_record", group: :test)
        Gemfiler.add("factory_bot_rails", group: :test)
        Gemfiler.add("simplecov", group: :test, required: false)
        Gemfiler.add("shoulda-matchers", group: :test)

        Gemfiler.uncomment_default_gems "rack-cors"
      end

      after :rails do
        template "rubocop.yml.erb", ".rubocop.yml"
        remove_file "spec/rails_helper.rb"
        copy_file "spec/rails_helper.rb"
        empty_directory "spec/factories"
        empty_directory "spec/models"
        empty_directory "spec/controllers"
      end

      after :all do
        append_to_file ".gitignore", "/.idea/"

        inside destination_root do
          run "bundle exec rubocop -A"
          commit "Initial commit."
        end
      end
    end
  end
end
