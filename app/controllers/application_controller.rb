# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale

  devise_group :user, contains: [:admin, :candidate, :recruiter]

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    flash.keep
    flash[:alert] ||= []
    flash[:alert] << t('application.invalid_authenticity_token')

    redirect_to(root_path)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('application.user_not_authorized')
    redirect_back(fallback_location: root_path)
  end

  def set_locale
    I18n.locale = params[:lang] || locale_form_header || I18n.default_locale
  end

  def locale_form_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{}2/).first
  end

  def default_url_options
    { lang: I18n.locale }
  end
end
