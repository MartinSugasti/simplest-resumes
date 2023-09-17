# frozen_string_literal: true

class Candidates::PaymentsController < ApplicationController
  before_action :authenticate_candidate!

  def index; end

  def checkout
    @session = Stripe::Checkout::Session.create({
      customer_email: current_user.email,
      line_items: [
        price_data: {
          currency: 'usd',
          product_data: {
            name: 'US$5 One Time Payment'
          },
          unit_amount: 500,

        },
        quantity: 1
      ],
      mode: 'payment',
      payment_method_types: ['card'],
      success_url: candidates_payments_url(success: true),
      cancel_url: candidates_payments_url(canceled: true)
    })

    render json: { url: @session.url }
  end
end
