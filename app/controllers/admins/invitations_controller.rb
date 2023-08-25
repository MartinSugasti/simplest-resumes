# frozen_string_literal: true

class Admins::InvitationsController < Devise::InvitationsController
  include Accessible

  before_action :check_if_resource_signed_in, only: [:edit, :update, :destroy]
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:role])
  end
end
