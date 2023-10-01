# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern

  protected

  def check_if_resource_already_signed_in
    if user_signed_in?
      flash.keep

      # In case it's not called from devise controller, in which case resource_name is not defined
      if !defined?(resource_name)
        flash[:alert] ||= []
        flash[:alert] << t('accesible.resource_already_signed_in', class: current_user.class)

        redirect_to(root_path(current_user)) and return
      end

      if controller_path == "#{resource_name.to_s.pluralize}/sessions" && action_name == 'create'
        redirect_to(root_path(resource_name)) and return
      end

      flash[:alert] ||= []
      flash[:alert] << t('accesible.resource_already_signed_in', class: current_user.class)

      redirect_to(root_path(resource_name)) and return
    end
  end

  def check_if_confirmation_available
    token = params[:confirmation_token]
    user = token && resource_class.find_by(confirmation_token: token)

    if token.blank?
      flash.keep
      flash[:alert] ||= []
      flash[:alert] << t('accesible.blank_token')

      redirect_to(root_path) and return
    elsif user.blank?
      flash.keep
      flash[:alert] ||= []
      flash[:alert] << t('accesible.invalid_token')

      redirect_to(root_path) and return
    elsif user.confirmed?
      flash.keep
      flash[:alert] ||= []
      flash[:alert] << t('accesible.already_confirmed', class: resource_class.to_s)

      redirect_to(root_path) and return
    end
  end
end
