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
    elsif candidate_signed_in?
      flash.clear
      flash[:alert] = "You're already signed in as a Candidate" unless controller_path.include?('candidates')

      redirect_to(candidates_authenticated_root_path) and return
    elsif recruiter_signed_in?
      flash.clear
      flash[:alert] = "You're already signed in as a Recruiter" unless controller_path.include?('recruiters')

      redirect_to(recruiters_authenticated_root_path) and return
    end
  end
end
