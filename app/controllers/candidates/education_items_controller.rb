# frozen_string_literal: true

class Candidates::EducationItemsController < ApplicationController
  before_action :authenticate_candidate!

  def create
    education_item = EducationItem.new(safe_params)
    authorize(education_item, policy_class: Candidates::ResumePolicy)

    if education_item.save
      render json: { id: education_item.id }, status: :ok
    else
      render json: { errors: education_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    education_item = EducationItem.find(params[:id])
    authorize(education_item, policy_class: Candidates::ResumePolicy)

    if education_item.destroy
      head :ok
    else
      render json: { errors: education_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:education_item).permit(:name, :institute, :start_year, :end_year, :resume_id)
  end
end
