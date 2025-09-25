source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.4'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.0'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use for serialization
gem 'active_model_serializers', '~> 0.10.13'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use sidekiq for jobs queueing
gem 'sidekiq', '~> 7.1'
gem 'sidekiq-failures', '~> 1.0'

# For scheduled processes
gem 'sidekiq-scheduler', '~> 5.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# For authentication
gem 'devise', '~> 4.9'
gem 'devise_invitable', '~> 2.0'

# For impresionation
gem 'devise_masquerade', '~> 2.1'

# For omniauth authentication
gem 'omniauth', '~> 2.1'
gem 'omniauth-github', '~> 2.0'
gem 'omniauth-google-oauth2', '~> 1.1'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'omniauth-twitter', '~> 1.4'

# For two-factor authentication
gem 'devise-two-factor', '~> 5.0'
gem 'rqrcode', '~> 2.2'

# For SMS
gem 'twilio-ruby', '~> 6.6'

# Payments
gem 'stripe', '~> 9.3'

# Active Storage validation
gem 'active_storage_validations', '~> 1.0'

# S3 storage
gem 'aws-sdk-s3', '~> 1.135', require: false

# Authorization
gem 'pundit', '~> 2.3'

# For passing the translations from backend .yml files to translations.json frontend file
gem 'i18n-js', '~> 4.2'

# Error tracking
gem 'honeybadger', '~> 5.15'

# OpenAI integration
gem 'ruby-openai', '~> 8.0'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Debugging
  gem 'pry', '~> 0.14.2'
  gem 'pry-byebug', '~> 3.10', '>= 3.10.1'

  # Ruby styles
  gem 'rubocop', require: false
  gem 'rubocop-git', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false

  # .erb styles
  gem 'erb_lint', require: false

  # For env variables
  gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Add a comment summarizing the current schema to the top models files
  gem 'annotate', '~> 3.2'

  # For opening emails in browser
  gem 'letter_opener', '~> 1.8'
end
