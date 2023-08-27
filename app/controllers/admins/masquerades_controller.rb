# frozen_string_literal: true

class Admins::MasqueradesController < Devise::MasqueradesController
  before_action :masquerade_candidate!
  before_action :masquerade_recruiter!

  protected

  def masquerade_authorize!
    if params[:action] != 'back'
      if !admin_signed_in?
        flash[:alert] = "You need to sign in as an Admin for impresionation."
        redirect_to root_path
      elsif !current_admin.super_admin?
        flash[:alert] = "You need to be a Super Admin for impresionation."
        redirect_to root_path
      end
    end
  end
end
