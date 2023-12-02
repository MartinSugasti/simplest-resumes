# frozen_string_literal: true

class Recruiters::ResumesController < ApplicationController
  before_action :authenticate_recruiter!

  def show
    respond_to do |format|
      format.html
      format.json { render json: Resume.find(params[:id]) }
    end
  end
end
