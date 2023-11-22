# frozen_string_literal: true

class Candidates::MyResumeController < ApplicationController
  before_action :authenticate_candidate!

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: current_candidate.resume || current_candidate.create_resume
      end
    end
  end

  def update
    resume = current_candidate.resume || current_candidate.create_resume
    authorize([:candidates, resume])

    if resume.update(safe_params)
      head :ok
    else
      render json: { errors: resume.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:resume).permit(:name, :email, :mobile, :location, :about_me)
  end
end
