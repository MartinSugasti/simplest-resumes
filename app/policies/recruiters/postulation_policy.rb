# frozen_string_literal: true

class Recruiters::PostulationPolicy < ApplicationPolicy
  def approve?
    record.job_posting.recruiter == user
  end

  def reject?
    record.job_posting.recruiter == user
  end
end
