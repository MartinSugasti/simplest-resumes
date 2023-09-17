# frozen_string_literal: true

class Admins::InvitationsMailer < ApplicationMailer
  default from: email_address_with_name('notifications@simplestresumes.com', 'Notifications'),
          to: -> { Admin.super_admin.pluck(:email) }

  def invitation_accepted_email(email)
    @email = email

    mail(subject: "Invitation accepted for #{email}")
  end

  def invitation_requested_email(email)
    @email = email

    mail(subject: "Invitation requested for #{email}")
  end

  def invitation_reminder_email(id)
    @admin = Admin.find(id)
    @admin.skip_invitation = true
    @admin.invite!

    mail(
      from: email_address_with_name('no-reply@simplestresumes.com', 'No Reply'),
      to: @admin.email,
      subject: "You have one pending invitation"
    )
  end
end