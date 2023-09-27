# frozen_string_literal: true

class Admins::MasqueradePolicy < ApplicationPolicy
  def masquerade?
    user.is_a?(Admin) && user.super_admin?
  end
end
