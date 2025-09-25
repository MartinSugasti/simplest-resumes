# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

class Admins::SessionsController < Devise::SessionsController
  include Accessible

  before_action :check_if_resource_already_signed_in, except: :destroy

  def create # rubocop:disable Metrics/AbcSize
    # Authenticate user with just email and password without signing them in
    email = params[:admin][:email]
    password = params[:admin][:password]

    resource = Admin.find_by(email: email)

    if resource&.valid_password?(password) && resource&.active_for_authentication?
      # If the user has 2FA enabled
      if resource.otp_required_for_login
        # Store the user ID temporarily. We're not saving the password in the session for security reasons.
        # Generate a signed token for the user ID.
        verifier = Rails.application.message_verifier(:otp_session)
        token = verifier.generate(resource.id)
        session[:otp_token] = token

        # Redirect the user to the OTP entry page (no need to sign out since we never signed them in)
        redirect_to admins_otp_path
      else
        # If 2FA is not required, log the user in
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      end
    else
      # If user authentication failed
      flash[:alert] = t('devise.failure.invalid', authentication_keys: 'Email')
      redirect_to new_admin_session_path
    end
  end
end

# rubocop:enable Rails/LexicallyScopedActionFilter
