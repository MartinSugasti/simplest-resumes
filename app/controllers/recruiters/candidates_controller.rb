# frozen_string_literal: true

class Recruiters::CandidatesController < ApplicationController
  before_action :authenticate_recruiter!

  def index
    respond_to do |format|
      format.html
      format.json { render json: Candidate.confirmed.order(:id), each_serializer: Recruiters::CandidateSerializer }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: Candidate.confirmed.find(params[:id]) }
    end
  end
end
