# frozen_string_literal: true

class Candidates::WorkExperienceItemsController < ApplicationController
  before_action :authenticate_candidate!

  def create
    work_experience_item = WorkExperienceItem.new(safe_params)
    authorize(work_experience_item, policy_class: Candidates::ResumePolicy)

    if work_experience_item.save
      render json: { id: work_experience_item.id }, status: :ok
    else
      render json: { errors: work_experience_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    work_experience_item = WorkExperienceItem.find(params[:id])
    authorize(work_experience_item, policy_class: Candidates::ResumePolicy)

    if work_experience_item.destroy
      head :ok
    else
      render json: { errors: work_experience_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:work_experience_item).permit(
      :company,
      :description,
      :end_month,
      :end_year,
      :location,
      :position,
      :start_month,
      :start_year,
      :resume_id
    )
  end
end
