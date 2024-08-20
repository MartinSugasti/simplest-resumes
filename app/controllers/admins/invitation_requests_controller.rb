# frozen_string_literal: true

class Admins::InvitationRequestsController < ApplicationController
  include Accessible

  before_action :authenticate_admin!, only: %i[index dismiss ban]
  before_action -> { authorize([:admins, InvitationRequest]) }, only: %i[index dismiss ban]
  before_action :check_if_resource_already_signed_in, only: %i[new create]

  def index
    respond_to do |format|
      format.html
      format.json { render json: InvitationRequest.order(:status) }
    end
  end

  def new
    @invitation_request = InvitationRequest.new
  end

  def create
    @invitation_request = InvitationRequest.new(email: safe_params[:email])

    if @invitation_request.save
      Admins::InvitationsMailer.invitation_requested_email(@invitation_request.email).deliver_later

      flash.now[:notice] ||= []
      flash.now[:notice] << t('.notice')
      render 'pages/home'
    else
      flash.now[:alert] ||= []
      flash.now[:alert] << @invitation_request.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def dismiss
    invitation_request = InvitationRequest.find(params[:id])

    if invitation_request.update(status: :dismissed)
      render json: t('.notice'), status: :ok
    else
      render json: invitation_request.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def ban
    invitation_request = InvitationRequest.find(params[:id])

    if invitation_request.update(status: :banned)
      render json: t('.notice'), status: :ok
    else
      render json: invitation_request.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:invitation_request).permit(:email)
  end
end
