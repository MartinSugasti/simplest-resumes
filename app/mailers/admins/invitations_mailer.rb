# frozen_string_literal: true

class Admins::InvitationsMailer < ApplicationMailer
  default from: email_address_with_name('notifications@simplestresumes.com', I18n.t('mailers.from.notifications')),
          to: -> { Admin.super_admin.pluck(:email) }

  def invitation_accepted_email(email)
    @email = email

    mail(subject: default_i18n_subject(email: email))
  end

  def invitation_requested_email(email)
    @email = email

    mail(subject: default_i18n_subject(email: email))
  end

  def invitation_reminder_email(id)
    @admin = Admin.find(id)
    @admin.skip_invitation = true
    @admin.invite!

    mail(
      from: email_address_with_name('no-reply@simplestresumes.com', I18n.t('mailers.from.no_reply')),
      to: @admin.email
    )
  end
end