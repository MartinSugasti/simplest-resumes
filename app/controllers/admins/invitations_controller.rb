# frozen_string_literal: true

class Admins::InvitationsController < Devise::InvitationsController
  include Accessible

  before_action :check_if_resource_already_signed_in, only: [:edit, :update, :destroy]
  before_action :check_if_resource_super_admin, only: [:new, :create]
  before_action :configure_permitted_parameters

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

  # This is called when accepting invitation.
  # It should return an instance of resource class.
  def accept_resource
    super do |admin|
      # TODO: Implement mailer for super admins when invitation is accepted
      Rails.logger.info('Send email in future commit') if admin.errors.empty?
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
