# frozen_string_literal: true

class Recruiters::PostulationsController < ApplicationController
  before_action :authenticate_recruiter!

  def approve
    postulation = Postulation.find(params[:postulation_id])
    authorize(postulation, policy_class: Recruiters::PostulationPolicy)

    if postulation.update(status: :approved)
      head :ok
    else
      render json: { errors: postulation.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def reject
    postulation = Postulation.find(params[:postulation_id])
    authorize(postulation, policy_class: Recruiters::PostulationPolicy)

    if postulation.update(status: :rejected)
      head :ok
    else
      render json: { errors: postulation.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:postulation).permit(:job_posting_id)
  end
end
