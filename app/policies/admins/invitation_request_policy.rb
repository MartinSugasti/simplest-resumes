# frozen_string_literal: true

class Admins::InvitationRequestPolicy < ApplicationPolicy
  def index?
    user.super_admin?
  end

  def dismiss?
    user.super_admin?
  end

  def ban?
    user.super_admin?
  end
end
