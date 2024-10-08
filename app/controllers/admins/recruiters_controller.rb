# frozen_string_literal: true

class Admins::RecruitersController < ApplicationController
  before_action :authenticate_admin!

  def index
    respond_to do |format|
      format.html
      format.json { render json: Recruiter.order(:id) }
    end
  end
end
