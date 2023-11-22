# frozen_string_literal: true

class Candidates::ResumePolicy < ApplicationPolicy
  def create?
    record.candidate == user
  end

  def update?
    record.candidate == user
  end

  def destroy?
    record.candidate == user
  end
end
