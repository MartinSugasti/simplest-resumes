# frozen_string_literal: true

class Admins::AdminsController < ApplicationController
  before_action :authenticate_admin!, except: %i[otp verify_otp]

  def index
    respond_to do |format|
      format.html
      format.json { render json: Admin.includes(:invited_by).order(:id) }
    end
  end

  def enable_otp_show_qr
    if current_admin.otp_required_for_login
      redirect_to edit_admin_registration_path, alert: t('admins.enable_otp_show_qr.2fa_already_enabled')
    else
      current_admin.otp_secret = Admin.generate_otp_secret
      issuer = 'Simplest Resumes'
      label = "#{issuer}:#{current_admin.email}"
      @provisioning_uri = current_admin.otp_provisioning_uri(label, issuer: issuer)

      current_admin.save!
    end
  end

  def enable_otp_verify
    if current_admin.validate_and_consume_otp!(params[:otp_attempt])
      current_admin.otp_required_for_login = true
      current_admin.save!

      redirect_to edit_admin_registration_path, notice: t('admins.enable_otp_show_qr.2fa_enabled_successfully')
    else
      redirect_to admins_enable_otp_show_qr_path, alert: t('devise.otp.invalid_otp')
    end
  end

  def otp
    # Render the OTP entry page
  end

  def verify_otp
    verifier = Rails.application.message_verifier(:otp_session)
    admin_id = verifier.verify(session[:otp_token])
    admin = Admin.find(admin_id)

    if admin.validate_and_consume_otp!(params[:otp_attempt])
      # OTP is correct. Log the admin in
      sign_in(:admin, admin)

      redirect_to root_path, notice: t('devise.sessions.signed_in')
    else
      flash[:alert] = t('devise.otp.invalid_otp')

      # Send them back to the sign in page, but don't show them the OTP entry page again.
      # This is because we don't want the admin to know whether the OTP code was invalid
      # because they didn't fill out the form correctly, or if the OTP code was just wrong.
      redirect_to new_admin_session_path
    end
  end
end
