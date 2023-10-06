# frozen_string_literal: true

class Recruiters::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :check_if_resource_already_signed_in, only: %i[new create]
  before_action :configure_permitted_parameters

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_picture, :preferred_language])
  end
end
