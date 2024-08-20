# frozen_string_literal: true

class Payments::CheckoutSessionMailer < ApplicationMailer
  def completed(email)
    mail(to: email)
  end
end
