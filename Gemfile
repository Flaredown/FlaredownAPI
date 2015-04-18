source  "https://rubygems.org"
ruby    "2.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
# gem "rails", github: "inopinatus/rails", branch: "hstore_arrays_fix"
gem "rails", "4.1.6"

gem "pg"
gem "couchrest_model"

gem "unicorn"

gem "sass-rails", "~> 4.0.2"
gem "uglifier", ">= 1.3.0"
# gem "coffee-rails", "~> 4.0.0"
# gem "emblem-rails"
gem "slim"

gem "skylight"
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"

gem "devise"
gem 'devise_invitable'

gem "oauth"
gem "active_model_serializers"

gem "resque"
gem "resque-scheduler", require: "resque_scheduler"
gem "redis"

gem 'eventmachine', "~> 1.0.4"
gem 'cancan'
gem "pusher"
gem "hashie"
gem "letter_opener"
gem "textacular", "~> 3.0"
gem 'paper_trail', github: "airblade/paper_trail", tag: "v4.0.0.beta2"
# gem 'newrelic_rpm'
gem "codeclimate-test-reporter", group: :test, require: nil
gem 'acts-as-taggable-on', '~> 3.4'

group :production do
end

group :development, :staging do
  gem "seedbank"
  gem 'distribution', '~> 0.7.1'
  # gem "gsl" # supposedly speeds up 'distribution`
end

group :doc do
  gem "tomdoc"
end

group :test, :development, :staging do
  gem "factory_girl_rails"#, require: false
  gem "timecop"
end

group :test, :development do
  gem "dotenv-rails"
  gem "pry"
  gem "pry-remote"
  gem "i18n-tasks", "~> 0.2.10"
  gem "ruby-prof"
end

group :development do
  gem "foreman"
end
group :test do
  gem "resque_spec"
  gem "rspec-rails"
  gem "pusher-fake"
  gem "database_cleaner"
  gem "simplecov"
  gem "coveralls", require: false
  gem "json_spec"
end

# Use ActiveModel has_secure_password
# gem "bcrypt-ruby", "~> 3.1.2"