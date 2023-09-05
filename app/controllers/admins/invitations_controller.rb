# frozen_string_literal: true

class Admins::InvitationsController < Devise::InvitationsController
  include Accessible

  before_action :check_if_resource_already_signed_in, only: [:edit, :update, :destroy]
  before_action :check_if_resource_super_admin, only: [:new, :create]
  before_action :configure_permitted_parameters

  def resend
    Admins::RemindInvitationsJob.perform_later

    flash[:notice] = "An email will be sent to Admins with pending invitations"
    redirect_to new_admin_invitation_path
  end

  def update
    super do |admin|
      Admins::InvitationsMailer.invitation_accepted_email(admin.email).deliver_later if admin.errors.empty?

      admin
    end
  end

  protected

  # This is called when creating invitation.
  # It should return an instance of resource class.
  def invite_resource
    super do |admin|
      break admin if admin.errors.any?

      invitation_request = InvitationRequest.find_by(email: admin.email)
      if !invitation_request&.approved? && invitation_request&.update(status: :approved)
        flash[:alert] ||= 'There was an invitation request for this email that was marked as Approved'
      end

      admin
    end
  end

  def after_invite_path_for(resource)
    new_admin_invitation_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:role])
  end
end
