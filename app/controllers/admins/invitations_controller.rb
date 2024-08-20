# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

class Admins::InvitationsController < Devise::InvitationsController
  include Accessible

  before_action :check_if_resource_already_signed_in, only: %i[edit update destroy]
  before_action -> { authorize(%i[admins invitation]) }, only: %i[new create]
  before_action :configure_permitted_parameters

  def resend
    Admins::RemindInvitationsJob.perform_later

    flash[:notice] ||= []
    flash[:notice] << t('.notice')
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
        flash[:alert] ||= []
        flash[:alert] << t('.invitation_request_marked_as_approved')
      end

      admin
    end
  end

  def after_invite_path_for(_resource)
    new_admin_invitation_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:role])
  end
end

# rubocop:enable Rails/LexicallyScopedActionFilter
