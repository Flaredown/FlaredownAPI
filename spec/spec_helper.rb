ENV["RAILS_ENV"] ||= 'test'

require "simplecov"
SimpleCov.start "rails"

require "couchrest"
Entry.all.each{|e| e.destroy} # destroy CouchDB docs

require File.expand_path("../../config/application", __FILE__)
require File.expand_path("../../config/environment", __FILE__)
I18n.default_locale = :en

require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rspec'
Capybara.javascript_driver  = :webkit
Capybara.default_selector   = :css
Capybara.ignore_hidden_elements = false

require 'resque_spec'
require "json_spec"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.include JsonSpec::Helpers
  # config.include Devise::TestHelpers, :type => :controller
  
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true
  
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  
end


DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean # cleanup of the test
# REDIS.flushdb

RSpec.configure do |config|
  config.around(:each) do |example|
    ResqueSpec.reset!
    FactoryGirl.reload
    Capybara.current_driver = :webkit
    example.run
    # REDIS.flushdb
    DatabaseCleaner.clean # cleanup of the test
    Entry.all.each{|e| e.destroy} # destroy CouchDB docs
    # CouchRest.database("http://127.0.0.1:5984/cdai_test").recreate!
    # sleep(0.01) # takes a second to recreate I guess
  end  
end

