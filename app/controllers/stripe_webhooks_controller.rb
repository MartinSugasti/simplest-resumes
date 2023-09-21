# frozen_string_literal: true

class StripeWebhooksController < ActionController::Metal
  include ActionController::Head

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
          payload, sig_header, Rails.configuration.stripe_signing_secret
      )
    rescue JSON::ParserError
      # Invalid payload
      Rails.logger.error("StripeWebhooks error: Invalid payload")

      status :bad_request
      return
    rescue Stripe::SignatureVerificationError
      # Invalid signature
      Rails.logger.error("StripeWebhooks error: Invalid signature")

      status :bad_request
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      data = event.data.object
      email = data.customer_details.email || data.metadata.customer_email

      Payments::CheckoutSessionMailer.completed(email).deliver_later
    else
      Rails.logger.info("StripeWebhooks alert: event type #{event.type} not supported")
    end

    head :ok
  end
end
