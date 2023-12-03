# frozen_string_literal: true

module Userable
  extend ActiveSupport::Concern

  def admin?
    is_a?(Admin)
  end

  def recruiter?
    is_a?(Recruiter)
  end

  def candidate?
    is_a?(Candidate)
  end
end