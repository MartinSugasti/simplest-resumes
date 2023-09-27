# frozen_string_literal: true

class Admins::InvitationPolicy < ApplicationPolicy
  def initialize(user, _record)
    @user = user
  end

  def new?
    user.super_admin?
  end

  def create?
    user.super_admin?
  end
end
