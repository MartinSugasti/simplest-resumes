# frozen_string_literal: true

class Admins::RemindInvitationsJob < ApplicationJob
  queue_as :default

  def perform
    Admin.invitation_not_accepted.each(&:invite!)
  end
end
