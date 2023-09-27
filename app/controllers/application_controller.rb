# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  devise_group :user, contains: [:admin, :candidate, :recruiter]

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    flash.keep
    flash[:alert] ||= []
    flash[:alert] << "Can't verify CSRF token authenticity"

    redirect_to(root_path)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
