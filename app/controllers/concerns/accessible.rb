# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_resource
  end

  protected

  def check_resource
    if admin_signed_in?
      flash.clear
      flash[:alert] = "You're already signed in as an Admin" unless controller_path.include?('admins')

      redirect_to(admins_authenticated_root_path) and return
    elsif user_signed_in?
      flash.clear
      flash[:alert] = "You're already signed in as an User" unless controller_path.include?('users')

      redirect_to(users_authenticated_root_path) and return
    end
  end
end
