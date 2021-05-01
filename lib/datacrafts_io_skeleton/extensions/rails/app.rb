# frozen_string_literal: true

module DatacraftsIoSkeleton
  module Extensions
    module Rails
      class App
        include Base

        hide_from_options!

        before :rails do
          Tools::Gemfiler.add("rubocop", group: :development, required: false)
          Tools::Gemfiler.add("rubocop-performance", group: :development, required: false)
          Tools::Gemfiler.add("rubocop-rails", group: :development, required: false)
          Tools::Gemfiler.add("rubocop-faker", group: :development, required: false)

          Tools::Gemfiler.add("faker", group: :development_test)
          Tools::Gemfiler.add("rspec", group: :development_test)
          Tools::Gemfiler.add("rspec-rails", group: :development_test)
          Tools::Gemfiler.add("rubocop-rspec", group: :development_test, required: false)

          Tools::Gemfiler.add("database_cleaner-active_record", group: :test)
          Tools::Gemfiler.add("factory_bot_rails", group: :test)
          Tools::Gemfiler.add("simplecov", group: :test, required: false)
          Tools::Gemfiler.add("shoulda-matchers", group: :test)

          Tools::Gemfiler.uncomment_default_gems "rack-cors"
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
end
