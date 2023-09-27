# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern

  protected

  def check_if_resource_already_signed_in
    if user_signed_in?
      flash.keep

      unless controller_path == "#{resource_name.to_s.pluralize}/sessions" && action_name == 'create'
        flash[:alert] ||= []
        flash[:alert] << " You're already signed in as a #{current_user.class}"
      end

      redirect_to(root_path(resource_name)) and return
    end
  end

  def check_if_confirmation_available
    token = params[:confirmation_token]
    user = token && resource_class.find_by(confirmation_token: token)

    if token.blank?
      flash.keep
      flash[:alert] ||= []
      flash[:alert] << "Confirmation token can't be blank"

      redirect_to(root_path) and return
    elsif user.blank?
      flash.keep
      flash[:alert] ||= []
      flash[:alert] << 'Confirmation token is invalid'

      redirect_to(root_path) and return
    elsif user.confirmed?
      flash.keep
      flash[:alert] ||= []
      flash[:alert] << "#{resource_class.to_s} already confirmed"

      redirect_to(root_path) and return
    end
  end
end
