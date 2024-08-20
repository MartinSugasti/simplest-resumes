# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

class Admins::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :check_if_resource_already_signed_in, only: %i[new create]
  before_action :sign_up_not_allowed, only: %i[new create]
  before_action :configure_permitted_parameters

  private

  def sign_up_not_allowed
    flash[:alert] ||= []
    flash[:alert] << t('.sign_up_not_allowed')

    redirect_to(root_path) and return
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role preferred_language])
    devise_parameter_sanitizer.permit(:account_update, keys: [:preferred_language])
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
