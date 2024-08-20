# frozen_string_literal: true

class ContactFormMailer < ApplicationMailer
  default from: email_address_with_name('no-reply@simplestresumes.com', I18n.t('mailers.from.contact_form')),
          to: -> { Admin.super_admin.pluck(:email) }

  def new_request(name, email, mobile, query)
    @name = name
    @email = email
    @mobile = mobile
    @query = query

    mail(reply_to: @email)
  end
end
