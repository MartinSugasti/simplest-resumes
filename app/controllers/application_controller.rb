# frozen_string_literal: true

class ApplicationController < ActionController::Base
  devise_group :user, contains: [:admin, :candidate, :recruiter]

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    flash.keep
    flash[:alert] = "Can't verify CSRF token authenticity"

    redirect_to(root_path)
  end
end
