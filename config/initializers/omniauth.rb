# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], {
    provider_ignores_state: true
  }
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']

  before_callback_phase do |env|
    # This is a workaround to get the resource class. If not, devise fails.
    devise_map = env["action_dispatch.request.unsigned_session_cookie"]["omniauth.origin"]

    if devise_map&.include?("candidate")
      env["devise.mapping"] = Devise.mappings[:candidate]
    else devise_map&.include?("recruiter")
      env["devise.mapping"] = Devise.mappings[:recruiter]
    end
  end

  on_failure do |env|
    OmniauthCallbacksController.action(:failure).call(env)
  end
end
