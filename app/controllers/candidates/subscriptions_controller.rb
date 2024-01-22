# frozen_string_literal: true

class Candidates::SubscriptionsController < ApplicationController
  before_action :authenticate_candidate!
  before_action :create_stripe_customer, only: %i[create billing_portal]

  def index; end

  def create
    session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price: params[:plan_id]
      }],
      success_url: candidates_subscriptions_url(success: true),
      cancel_url: candidates_subscriptions_url(canceled: true)
    })

    render json: { url: session.url }
  end

  def prices
    prices = Stripe::Price.list(lookup_keys: %w[monthly yearly], active: true).data.sort_by(&:unit_amount)

    data = prices.map do |price|
      PriceSerializer.new(price).serializable_hash
    end

    render json: {
      subscription_data: SubscriptionSerializer.new(current_user).serializable_hash,
      prices: data
    }
  end

  def billing_portal
    session = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer_id,
      return_url: candidates_subscriptions_url
    })

    redirect_to session.url, allow_other_host: true
  end

  private

  def create_stripe_customer
    return if current_user.stripe_customer_id.present?

    stripe_customer = Stripe::Customer.create(email: current_user.email)
    current_user.update(stripe_customer_id: stripe_customer.id)
  end
end
