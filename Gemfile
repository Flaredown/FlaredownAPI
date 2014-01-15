source  "https://rubygems.org"
ruby    "2.0.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "4.0.2"

gem "pg"
gem "couchrest_model"

gem "sass-rails", "~> 4.0.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "emblem-rails"
gem "slim"

gem "devise"
gem "active_model_serializers"

gem "resque"
gem "redis-rails"

group :production do
  gem 'rails_12factor' # for heroku asset compilation
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc", require: false
end

group :test, :development do
  gem "rspec-rails"
  gem "guard-rspec"
  gem "capybara"
  gem "factory_girl"
  gem "factory_girl_rails"
  gem "database_cleaner"
  gem "capybara-webkit"
  gem "selenium-webdriver"
  gem "timecop"
  gem "teaspoon"
  gem "simplecov"
  gem "pry"
  gem "coveralls"
  gem "json_spec"
end

group :test do
  gem "resque_spec"
end


# Use ActiveModel has_secure_password
# gem "bcrypt-ruby", "~> 3.1.2"

# Use unicorn as the app server
# gem "unicorn"

# Use Capistrano for deployment
# gem "capistrano", group: :development

# Use debugger
# gem "debugger", group: [:development, :test]
