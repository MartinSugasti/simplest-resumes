# frozen_string_literal: true

class Admins::InvitationsController < Devise::InvitationsController
  include Accessible

  before_action :check_if_resource_signed_in, only: [:edit, :update, :destroy]
  before_action :check_if_resource_super_admin, only: [:new, :create]
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [:role])
  end

  def check_if_resource_super_admin
    unless current_admin.super_admin?
      flash[:alert] = "You need to be a Super Admin for inviting admins."
      redirect_to root_path
    end
  end
end
