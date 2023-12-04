# frozen_string_literal: true

class Admins::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    respond_to do |format|
      format.html
      format.json { render json: Admin.includes(:invited_by).order(:id) }
    end
  end
end
