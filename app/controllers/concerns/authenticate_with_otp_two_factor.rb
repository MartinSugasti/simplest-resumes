# frozen_string_literal: true

# TODO: Add support for other recruiters and candidates. Currently only admins are supported.
module AuthenticateWithOtpTwoFactor
  extend ActiveSupport::Concern

  def authenticate_with_otp_two_factor
    admin = self.resource = find_admin

    if admin_params[:otp_attempt].present? && session[:otp_admin_id]
      authenticate_admin_with_otp_two_factor(admin)
    elsif admin&.valid_password?(admin_params[:password])
      prompt_for_otp_two_factor(admin)
    end
  end

  private

  def find_admin
    if session[:otp_admin_id]
      Admin.find(session[:otp_admin_id])
    elsif admin_params[:email]
      Admin.find_by(email: admin_params[:email])
    end
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :remember_me, :otp_attempt)
  end

  def authenticate_admin_with_otp_two_factor(admin)
    if valid_otp_attempt?(admin)
      # Remove any lingering admin data from login
      session.delete(:otp_admin_id)
      remember_me(admin) if admin_params[:remember_me] == '1'
      admin.save!

      sign_in(admin, event: :authentication)
    else
      flash.now[:alert] = t('devise.otp.invalid_otp')

      prompt_for_otp_two_factor(admin)
    end
  end

  def valid_otp_attempt?(admin)
    admin.validate_and_consume_otp!(admin_params[:otp_attempt])
  end

  def prompt_for_otp_two_factor(admin)
    @admin = admin
    session[:otp_admin_id] = admin.id

    render 'admins/sessions/otp'
  end

  def otp_two_factor_enabled?
    find_admin&.otp_required_for_login
  end
end
