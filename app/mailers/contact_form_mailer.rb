# frozen_string_literal: true

class ContactFormMailer < ApplicationMailer
  default from: email_address_with_name('no-reply@simplestresumes.com', 'Contact Form'),
          to: -> { Admin.super_admin.pluck(:email) }

  def new_request(name, email, mobile, query)
    @name = name
    @email = email
    @mobile = mobile
    @query = query

    mail(subject: 'New Request through Contact Form', reply_to: @email)
  end
end