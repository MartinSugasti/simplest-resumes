# frozen_string_literal: true

class Admins::ConfirmationsController < Devise::ConfirmationsController
  include Accessible

  before_action :check_if_resource_already_signed_in
  before_action :check_if_confirmation_available, only: :show
  before_action :needs_invitation, only: %i[new create]

  private

  def needs_invitation
    flash.keep
    flash[:alert] ||= []
    flash[:alert] << t('.needs_invitation_html', email: Rails.configuration.contact_email)

    redirect_to(root_path) and return
  end
end
