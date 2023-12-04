# frozen_string_literal: true

class Candidates::PostulationsController < ApplicationController
  before_action :authenticate_candidate!

  def create
    postulation = current_candidate.postulations.build(safe_params)
    authorize(postulation, policy_class: Candidates::PostulationPolicy)

    if postulation.save
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
