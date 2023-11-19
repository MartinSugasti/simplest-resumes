# frozen_string_literal: true

class Candidates::ReferenceItemsController < ApplicationController
  before_action :authenticate_candidate!

  def create
    reference_item = ReferenceItem.new(safe_params)

    if reference_item.save
      render json: { id: reference_item.id }, status: :ok
    else
      render json: { errors: reference_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    reference_item = ReferenceItem.find(params[:id])

    if reference_item.destroy
      head :ok
    else
      render json: { errors: reference_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:reference_item).permit(
      :company,
      :kind,
      :mobile,
      :name,
      :position,
      :resume_id
    )
  end
end
