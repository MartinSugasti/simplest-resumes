require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SimplestResumes
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

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

    config.action_mailer.default_url_options = { :host => 'simplestresumes.com' }
    config.action_mailer.smtp_settings = {
      :user_name => 'apikey',
      :password => ENV['SENDGRID_API_KEY'],
      :domain => 'simplestresumes.com',
      :address => 'smtp.sendgrid.net',
      :port => 587,
      :authentication => :plain,
      :enable_starttls_auto => true
    }

    config.contact_email = ENV.fetch('CONTACT_EMAIL', 'martinsugasti@gmail.com')

    # External services keys
    config.github_key = ENV['GITHUB_KEY']
    config.github_secret = ENV['GITHUB_SECRET']

    config.google_client_id = ENV['GOOGLE_CLIENT_ID']
    config.google_client_secret = ENV['GOOGLE_CLIENT_SECRET']

    config.twitter_key = ENV['TWITTER_KEY']
    config.twitter_secret = ENV['TWITTER_SECRET']

    config.sendgrid_api_key = ENV['SENDGRID_API_KEY']

    config.twilio_account_sid = ENV['TWILIO_ACCOUNT_SID']
    config.twilio_auth_token = ENV['TWILIO_AUTH_TOKEN']
    config.twilio_from_phone = ENV['TWILIO_FROM_PHONE']
    config.twilio_test_phone = ENV['TWILIO_TEST_PHONE']

    config.stripe_api_key = ENV['STRIPE_API_KEY']
    config.stripe_secret_key = ENV['STRIPE_SECRET_KEY']
    config.stripe_signing_secret = ENV['STRIPE_SIGNING_SECRET']

    config.google_recaptcha_site_key = ENV['GOOGLE_RECAPTCHA_SITE_KEY']
    config.google_recaptcha_secret_key = ENV['GOOGLE_RECAPTCHA_SECRET_KEY']
  end
end
