# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
  skip_before_action :verify_authenticity_token, only: [:github, :google_oauth2, :twitter]

  def github
    general_callback('Github')
  end

  def google_oauth2
    general_callback('Google')
  end

  def twitter
    general_callback('Twitter')
  end

  def failure
    flash[:alert] ||= []
    flash[:alert] << t('.alert')
    redirect_to root_path
  end

  private

  def general_callback(provider_name)
    # You need to implement the method below in your model (e.g. app/models/resource_class.rb)
    @resource = resource_class.from_omniauth(request.env["omniauth.auth"])

    if @resource.persisted?
      @resource.confirm
      sign_in_and_redirect @resource, event: :authentication # this will throw if @resource is not activated
      set_flash_message(:notice, :success, kind: provider_name) if is_navigational_format?
    else
      flash[:alert] ||= []

      if @resource.email.blank?
        flash[:alert] << t('omniauth_callbacks.no_email', provider_name: provider_name)
      else
        flash[:alert] << @resource.errors.full_messages.to_sentence
      end

      redirect_to new_session_url(@resource)
    end
  end
end
