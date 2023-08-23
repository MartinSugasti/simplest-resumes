# frozen_string_literal: true

class Recruiters::DashboardController < ApplicationController
  before_action :authenticate_recruiter!

  def show; end
end
