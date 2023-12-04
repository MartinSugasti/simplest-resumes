# frozen_string_literal: true

class Recruiters::PostulationPolicy < ApplicationPolicy
  def approve?
    record.recruiter == user
  end

  def reject?
    record.recruiter == user
  end
end
