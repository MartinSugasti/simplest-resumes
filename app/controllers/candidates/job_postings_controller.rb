# frozen_string_literal: true

class Candidates::JobPostingsController < ApplicationController
  before_action :authenticate_candidate!, except: :show

  def index
    respond_to do |format|
      format.html
      format.json { render json: JobPosting.published }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: JobPosting.published.find(params[:id]) }
    end
  end
end
