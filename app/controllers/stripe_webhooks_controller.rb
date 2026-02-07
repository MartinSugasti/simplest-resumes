# frozen_string_literal: true

class StripeWebhooksController < ActionController::Metal
  include ActionController::Head

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.configuration.stripe_signing_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      Rails.logger.error('StripeWebhooks error: Invalid payload')
      Honeybadger.notify(e, context: { payload: payload })

      head :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      Rails.logger.error('StripeWebhooks error: Invalid signature')
      Honeybadger.notify(e, context: { payload: payload })

      head :bad_request
      return
    end

    # Handle the event
    case event.type
    when 'customer.created'
      stripe_customer = event.data.object
      candidate = Candidate.find_by(email: stripe_customer.email)

      if candidate.nil?
        msg = "StripeWebhooks alert: candidate not found with email #{stripe_customer.email}"
        Rails.logger.error(msg)
        Honeybadger.notify(msg, context: { payload: payload })
      elsif candidate.stripe_customer_id.present?
        if candidate.stripe_customer_id != stripe_customer.id
          msg = "StripeWebhooks alert: candidate #{candidate.email} is already associated to " \
                "Stripe Customer #{candidate.stripe_customer_id} and cannot be associated to " \
                "Stripe Customer #{stripe_customer.id}"
          Rails.logger.error(msg)
          Honeybadger.notify(msg, context: { payload: payload })
        end
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

      if candidate.nil?
        msg = "StripeWebhooks alert: candidate not found with stripe_customer_id #{subscription.customer}"
        Rails.logger.error(msg)
        Honeybadger.notify(msg, context: { payload: payload })
      else
        candidate.update(
          plan: subscription.items.data[0].price.recurring.interval,
          subscription_ends_at: Time.zone.at(subscription.current_period_end).to_datetime
        )
      end
    else
      msg = "StripeWebhooks alert: event type #{event.type} not supported"
      Rails.logger.error(msg)
      Honeybadger.notify(msg, context: { payload: payload })
    end

    head :ok
  end
end
