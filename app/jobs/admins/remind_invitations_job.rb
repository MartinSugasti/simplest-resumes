# frozen_string_literal: true

class Admins::RemindInvitationsJob < ApplicationJob
  queue_as :default

  def perform
    Admin.invitation_not_accepted.each do |admin|
      Admins::InvitationsMailer.invitation_reminder_email(admin.id).deliver_later
    end
  end
end
