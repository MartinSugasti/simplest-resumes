# frozen_string_literal: true

class Admins::MasqueradesController < Devise::MasqueradesController
  before_action :masquerade_candidate!
  before_action :masquerade_recruiter!

  protected

  def find_masqueradable_resource
    if params[:resource_id].present?
      masqueraded_resource_class.find(params[:resource_id])
    else
      super
    end
  end

  def masquerade_authorize!
    authorize([:admins, :masquerade], :masquerade?) unless params[:action] == 'back'
  end
end
