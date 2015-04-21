Flaredown::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_assets  = true
  config.static_cache_control = "public, max-age=3600"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  config.force_ssl = false

  config.action_mailer.asset_host = "http://#{ENV["HOSTNAME"]}"
  config.action_mailer.default_url_options = { :host => "http://#{ENV["HOSTNAME"]}"}
  # ActionMailer::Base.smtp_settings = {
  #     :port =>           ENV["MAIL_PORT"].to_i,
  #     :address =>        ENV["MAIL_ADDRESS"],
  #     :user_name =>      ENV['MANDRILL_USERNAME'],
  #     :password =>       ENV['MANDRILL_APIKEY'],
  #     :domain =>         ENV["MAIL_DOMAIN"],
  #     :enable_starttls_auto => true,
  #     :authentication => "login"
  # }
  config.action_mailer.delivery_method = :test
end
