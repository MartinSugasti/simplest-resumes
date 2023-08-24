# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern

  protected

  def check_if_resource_signed_in
    if admin_signed_in? || candidate_signed_in? || recruiter_signed_in?
      flash.keep
      unless controller_path == 'admins/sessions' && action_name == 'create'
        flash[:alert] = "You're already signed in as a #{resource_class.to_s}"
      end

      redirect_to(root_path(resource_name)) and return
    end
  end

  def check_if_confirmation_available
    token = params[:confirmation_token]
    user = token && resource_class.find_by(confirmation_token: token)

    if token.blank?
      flasj.keep
      flash[:alert] = "Confirmation token can't be blank"

      redirect_to(root_path) and return
    elsif user.blank?
      flasj.keep
      flash[:alert] = 'Confirmation token is invalid'

      redirect_to(root_path) and return
    elsif user.confirmed?
      flasj.keep
      flash[:alert] = "#{resource_class.to_s} already confirmed"

      redirect_to(root_path) and return
    end
  end
end
