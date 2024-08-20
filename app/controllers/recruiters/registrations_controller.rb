# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

class Recruiters::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :check_if_resource_already_signed_in, only: %i[new create]
  before_action :configure_permitted_parameters

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[profile_picture preferred_language])
  end

  def update_resource(resource, params)
    if params[:password].present?
      super
    else
      resource.update_without_password(params.except(:current_password))
    end
  end
end

# rubocop:enable Rails/LexicallyScopedActionFilter
