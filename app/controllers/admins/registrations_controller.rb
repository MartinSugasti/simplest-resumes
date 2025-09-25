# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

class Admins::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :check_if_resource_already_signed_in, only: %i[new create]
  before_action :sign_up_not_allowed, only: %i[new create]
  before_action :configure_permitted_parameters

  def update # rubocop:disable Metrics/AbcSize
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    otp_attempt = params[:admin][:otp_attempt]
    current_password = params[:admin][:current_password]

    # Check if Admin is trying to disable 2FA, besides other updates
    if resource.otp_required_for_login && otp_attempt.present? && current_password.present?
      # Validate OTP and password
      valid_otp = resource.validate_and_consume_otp!(otp_attempt)
      valid_password = resource.valid_password?(current_password)

      if valid_otp && valid_password
        resource.otp_required_for_login = false
        resource.save!

        flash[:notice] = t('devise.otp.disabled')

        # Update other fields
        super
      else
        flash[:alert] = appropriate_error_message(valid_otp, valid_password)

        redirect_to edit_registration_path(resource_name)
      end
    else
      # Admin is not trying to disable 2FA, just update other fields
      super
    end
  end

  private

  def sign_up_not_allowed
    flash[:alert] ||= []
    flash[:alert] << t('.sign_up_not_allowed')

    redirect_to(root_path) and return
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[otp_attempt])
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role preferred_language])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[preferred_language otp_attempt otp_required_for_login])
  end

  def update_resource(resource, params)
    if params[:password].present? || params[:otp_attempt].present?
      super
    else
      resource.update_without_password(params.except(:current_password))
    end
  end

  def appropriate_error_message(valid_otp, valid_password)
    return t('devise.otp.invalid_otp') if valid_password
    return t('devise.otp.invalid_password') if valid_otp

    t('devise.otp.invalid_otp_and_password')
  end
end

# rubocop:enable Rails/LexicallyScopedActionFilter
