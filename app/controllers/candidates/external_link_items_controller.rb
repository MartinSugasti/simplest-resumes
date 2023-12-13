# frozen_string_literal: true

class Candidates::ExternalLinkItemsController < ApplicationController
  before_action :authenticate_candidate!

  def create
    external_link_item = ExternalLinkItem.new(safe_params)
    authorize(external_link_item, policy_class: Candidates::ResumePolicy)

    if external_link_item.save
      render json: { id: external_link_item.id }, status: :ok
    else
      render json: { errors: external_link_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    external_link_item = ExternalLinkItem.find(params[:id])
    authorize(external_link_item, policy_class: Candidates::ResumePolicy)

    if external_link_item.destroy
      head :ok
    else
      render json: { errors: external_link_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:external_link_item).permit(:name, :url, :resume_id)
  end
end
