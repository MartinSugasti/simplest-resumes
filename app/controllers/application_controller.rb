# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :bindin

  def bindin
    binding.pry
  end
end
