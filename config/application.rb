require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Flaredown
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.active_record.schema_format = :sql

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/*_base.{rb,yml}').to_s]

    config.skylight.environments += ['staging']
    config.skylight.probes = %w(net_http redis)

    config.force_ssl = true

    # for Raven/Sentry
    # config.action_dispatch.show_exceptions = false

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'utc'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :en
    # I18n.available_locales = %i( en )
    # I18n.enforce_available_locales = true


    config.action_mailer.smtp_settings = {
      :address   => "smtp.mandrillapp.com",
      :port      => 587,
      :user_name => ENV["MANDRILL_USERNAME"],
      :password  => ENV["MANDRILL_KEY"]
    }

    # ActionMailer Config
    config.action_mailer.default_url_options = { :host => ENV["EMAIL_HOSTNAME"] }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = false
  end
end
