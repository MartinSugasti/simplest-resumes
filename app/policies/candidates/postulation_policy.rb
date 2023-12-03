# frozen_string_literal: true

class Candidates::PostulationPolicy < ApplicationPolicy
  def create?
    record.candidate == user
  end
end
