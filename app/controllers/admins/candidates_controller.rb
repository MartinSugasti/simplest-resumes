# frozen_string_literal: true

class Admins::CandidatesController < ApplicationController
  before_action :authenticate_admin!

  def index
    respond_to do |format|
      format.html
      format.json { render json: Candidate.all.order(:id), each_serializer: Admins::CandidateSerializer }
    end
  end
end
