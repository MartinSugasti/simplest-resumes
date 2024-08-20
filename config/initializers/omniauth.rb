# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.configuration.github_key, Rails.configuration.github_secret, {
    provider_ignores_state: true
  }
  provider :google_oauth2, Rails.configuration.google_client_id, Rails.configuration.google_client_secret
  provider :twitter, Rails.configuration.twitter_key, Rails.configuration.twitter_secret

  before_callback_phase do |env|
    env['devise.mapping'] = map_resource(env)
  end

  on_failure do |env|
    env['devise.mapping'] = map_resource(env)
    OmniauthCallbacksController.action(:failure).call(env)
  end

  def map_resource(env)
    # This is a workaround to get the resource class. If not, devise fails.
    devise_map = env['action_dispatch.request.unsigned_session_cookie']['omniauth.origin'] || env['HTTP_REFERER']

    if devise_map&.include?('candidate')
      Devise.mappings[:candidate]
    else
      devise_map&.include?('recruiter')
      Devise.mappings[:recruiter]
    end
  end
end
