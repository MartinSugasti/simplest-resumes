# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_locale

  devise_group :user, contains: %i[admin candidate recruiter]

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    flash.keep
    flash[:alert] ||= []
    flash[:alert] << t('application.invalid_authenticity_token')
    Honeybadger.notify(exception)

    redirect_to(root_path)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    Honeybadger.notify(exception)

    respond_to do |format|
      format.html do
        flash[:alert] = t('application.user_not_authorized')
        redirect_back(fallback_location: root_path)
      end
      format.json do
        render json: { errors: t('application.user_not_authorized') }, status: :unauthorized
      end
    end
  end

  def set_locale
    I18n.locale = if user_signed_in?
                    current_user.preferred_language
                  elsif params[:lang].present? && I18n.available_locales.include?(params[:lang].to_sym)
                    params[:lang]
                  else
                    locale_from_header || I18n.default_locale
                  end
  end

  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end

  def default_url_options
    return {} if user_signed_in? || params[:lang].blank?

    { lang: params[:lang] }
  end
end
