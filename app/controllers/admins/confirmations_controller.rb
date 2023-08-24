# frozen_string_literal: true

class Admins::ConfirmationsController < Devise::ConfirmationsController
  include Accessible

  before_action :check_if_resource_signed_in
  before_action :check_if_confirmation_available, only: :show
  before_action :needs_invitation, only: %i[new create]

  private

  def needs_invitation
    flash.keep
    flash[:alert] = "Admins need an invitation. If you haven't receive one, please contact "\
                    "<a href='mailto:admin@example.com' class='text-muted'>admin@example.com</a>"

    redirect_to(root_path) and return
  end
end
