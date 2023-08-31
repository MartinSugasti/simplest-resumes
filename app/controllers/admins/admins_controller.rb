# frozen_string_literal: true

class Admins::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    respond_to do |format|
      format.html
      format.json { render json: Admin.all.order(:id), each_serializer: Admins::AdminSerializer }
    end
  end
end
