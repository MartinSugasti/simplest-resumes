# frozen_string_literal: true

class Admins::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    respond_to do |format|
      format.html
      format.json { render json: Admin.includes(:invited_by).order(:id) }
    end
  end

  def enable_otp
    if current_admin.otp_required_for_login
      redirect_to edit_admin_registration_path, alert: t('admins.enable_otp.2fa_already_enabled')
    else
      current_admin.otp_secret = Admin.generate_otp_secret
      @provisioning_uri = current_admin.otp_provisioning_uri(
        "Simplest Resumes:#{current_admin.email}", issuer: 'Simplest Resumes'
      )

      current_admin.save!
    end
  end

  def enable_otp_verify
    if current_admin.validate_and_consume_otp!(params[:otp_attempt])
      current_admin.otp_required_for_login = true
      current_admin.save!

      redirect_to edit_admin_registration_path, notice: t('admins.enable_otp.2fa_enabled_successfully')
    else
      redirect_to admins_enable_otp_path, alert: t('devise.otp.invalid_otp')
    end
  end

  def disable_otp
    return if current_admin.otp_required_for_login

    redirect_to edit_admin_registration_path, alert: t('admins.disable_otp.2fa_already_disabled')
  end

  def disable_otp_verify
    if current_admin.otp_required_for_login
      otp_attempt = params[:admin][:otp_attempt]
      current_password = params[:admin][:current_password]

      if otp_attempt.blank? || current_password.blank?
        redirect_to admins_disable_otp_path, alert: t('devise.otp.missing_password_or_otp')
      else
        valid_password = current_admin.valid_password?(current_password)
        valid_otp = current_admin.validate_and_consume_otp!(otp_attempt)

        if valid_password && valid_otp
          current_admin.update!(otp_required_for_login: false)

          redirect_to edit_admin_registration_path, notice: t('devise.otp.disabled')
        else
          redirect_to admins_disable_otp_path, alert: appropriate_error_message(valid_otp, valid_password)
        end
      end
    else
      redirect_to edit_admin_registration_path, alert: t('admins.disable_otp.2fa_already_disabled')
    end
  end

  private

  def appropriate_error_message(valid_otp, valid_password)
    return t('devise.otp.invalid_otp') if valid_password
    return t('devise.otp.invalid_password') if valid_otp

    t('devise.otp.invalid_otp_and_password')
  end
end
