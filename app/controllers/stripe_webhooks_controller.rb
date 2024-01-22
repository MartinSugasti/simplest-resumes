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
    when 'customer.created'
      stripe_customer = event.data.object
      candidate = Candidate.find_by(email: stripe_customer.email)

      if candidate.nil?
        Rails.logger.info("StripeWebhooks alert: candidate not found with email #{stripe_customer.email}")
      elsif candidate.stripe_customer_id.present?
        Rails.logger.info(
          "StripeWebhooks alert: candidate #{stripe_customer.email} already has " \
          "the Stripe Customer #{candidate.stripe_customer_id}"
        )
      else
        candidate.update(stripe_customer_id: stripe_customer.id)
      end
    when 'checkout.session.completed'
      data = event.data.object
      email = data.customer_details.email || data.metadata.customer_email

      Payments::CheckoutSessionMailer.completed(email).deliver_later
    when 'customer.subscription.deleted', 'customer.subscription.updated', 'customer.subscription.created'
      subscription = event.data.object
      candidate = Candidate.find_by(stripe_customer_id: subscription.customer)

      candidate.update(
        plan: subscription.items.data[0].price.recurring.interval,
        subscription_ends_at: Time.at(subscription.current_period_end).to_datetime
      )
    else
      Rails.logger.info("StripeWebhooks alert: event type #{event.type} not supported")
    end

    head :ok
  end
end
