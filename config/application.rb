require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SimplestResumes # rubocop:disable Style/ClassAndModuleChildren
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.active_job.queue_adapter = :sidekiq

    config.action_mailer.default_url_options = { host: 'simplestresumes.com' }
    config.action_mailer.smtp_settings = {
      user_name: ENV.fetch('MAILGUN_SMTP_USER', nil),
      password: ENV.fetch('MAILGUN_SMTP_PASSWORD', nil),
      domain: 'simplestresumes.com',
      address: ENV.fetch('MAILGUN_DOMAIN', nil),
      port: 587,
      authentication: :plain,
      enable_starttls_auto: true
    }

    config.i18n.available_locales = %i[en es]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
    config.i18n.load_path += Dir[Rails.root.join('config/locales/*.{rb,yml}')]
    config.active_model.i18n_customize_full_message = true

    config.contact_email = ENV.fetch('CONTACT_EMAIL', 'martinsugasti@gmail.com')

    # External services keys
    config.github_key = ENV.fetch('GITHUB_KEY', nil)
    config.github_secret = ENV.fetch('GITHUB_SECRET', nil)

    config.google_client_id = ENV.fetch('GOOGLE_CLIENT_ID', nil)
    config.google_client_secret = ENV.fetch('GOOGLE_CLIENT_SECRET', nil)

    config.twitter_key = ENV.fetch('TWITTER_KEY', nil)
    config.twitter_secret = ENV.fetch('TWITTER_SECRET', nil)

    config.twilio_account_sid = ENV.fetch('TWILIO_ACCOUNT_SID', nil)
    config.twilio_auth_token = ENV.fetch('TWILIO_AUTH_TOKEN', nil)
    config.twilio_from_phone = ENV.fetch('TWILIO_FROM_PHONE', nil)
    config.twilio_test_phone = ENV.fetch('TWILIO_TEST_PHONE', nil)

    config.stripe_api_key = ENV.fetch('STRIPE_API_KEY', nil)
    config.stripe_secret_key = ENV.fetch('STRIPE_SECRET_KEY', nil)
    config.stripe_signing_secret = ENV.fetch('STRIPE_SIGNING_SECRET', nil)

    config.google_recaptcha_site_key = ENV.fetch('GOOGLE_RECAPTCHA_SITE_KEY', nil)
    config.google_recaptcha_secret_key = ENV.fetch('GOOGLE_RECAPTCHA_SECRET_KEY', nil)
  end
end
