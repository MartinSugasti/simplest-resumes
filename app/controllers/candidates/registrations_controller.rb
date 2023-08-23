# frozen_string_literal: true

class Candidates::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :check_resource, except: %i[new create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
