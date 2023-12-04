# frozen_string_literal: true

class Recruiters::JobPostingPolicy < ApplicationPolicy
  def create?
    record.recruiter == user
  end

  def show?
    record.recruiter == user
  end

  def edit?
    record.recruiter == user
  end

  def update?
    record.recruiter == user
  end

  def destroy?
    record.recruiter == user
  end
end
