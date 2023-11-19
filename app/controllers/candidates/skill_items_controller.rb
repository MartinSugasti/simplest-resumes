# frozen_string_literal: true

class Candidates::SkillItemsController < ApplicationController
  before_action :authenticate_candidate!

  def create
    skill_item = SkillItem.new(safe_params)

    if skill_item.save
      render json: { id: skill_item.id }, status: :ok
    else
      render json: { errors: skill_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    skill_item = SkillItem.find(params[:id])

    if skill_item.destroy
      head :ok
    else
      render json: { errors: skill_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:skill_item).permit(:name, :kind, :resume_id)
  end
end
