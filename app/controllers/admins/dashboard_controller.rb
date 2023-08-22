# frozen_string_literal: true

class Admins::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def show; end
end
