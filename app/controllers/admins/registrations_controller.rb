# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :check_if_resource_signed_in, only: %i[new create]
  before_action :sign_up_not_allowed, only: %i[new create]
  before_action :configure_permitted_parameters

  private

  def sign_up_not_allowed
    flash[:alert] = "Admins need an invitation to sign up"

    redirect_to(root_path) and return
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
