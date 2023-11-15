# frozen_string_literal: true

class Candidates::MyResumeController < ApplicationController
  before_action :authenticate_candidate!

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: current_candidate.resume || Resume.new, serializer: ResumeSerializer
      end
    end
  end
end
