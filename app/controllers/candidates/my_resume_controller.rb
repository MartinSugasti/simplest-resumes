# frozen_string_literal: true

class Candidates::MyResumeController < ApplicationController
  before_action :authenticate_candidate!

  def show
  end
end
