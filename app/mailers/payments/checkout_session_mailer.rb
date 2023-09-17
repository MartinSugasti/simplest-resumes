# frozen_string_literal: true

class Payments::CheckoutSessionMailer < ApplicationMailer
  def completed(email)
    mail(to: email, subject: 'Payment Accepted')
  end
end