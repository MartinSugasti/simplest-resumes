# frozen_string_literal: true

class Admins::InvitationRequestsController < ApplicationController
  include Accessible

  before_action :authenticate_admin!, only: [:index, :dismiss, :ban]
  before_action :check_if_resource_super_admin, only: [:index, :dismiss, :ban]
  before_action :check_if_resource_already_signed_in, only: [:new, :create]

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: InvitationRequest.all.order(:status),
               each_serializer: Admins::InvitationRequestSerializer
      end
    end
  end

  def new
    @invitation_request = InvitationRequest.new
  end

  def create
    @invitation_request = InvitationRequest.new(email: params[:invitation_request][:email])

    if @invitation_request.save
      Admins::InvitationsMailer.invitation_requested_email(@invitation_request.email).deliver_later

      flash.now[:notice] = 'Your request will be reviewed soon'
      render "pages/home"
    else
      flash.now[:alert] = @invitation_request.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def dismiss
    invitation_request = InvitationRequest.find(params[:id])

    if invitation_request.update(status: :dismissed)
      render json: 'Request dismissed', status: :ok
    else
      render json: invitation_request.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def ban
    invitation_request = InvitationRequest.find(params[:id])

    if invitation_request.update(status: :banned)
      render json: 'Request banned', status: :ok
    else
      render json: invitation_request.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end
end
