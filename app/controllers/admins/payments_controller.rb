# frozen_string_literal: true

class Admins::PaymentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    respond_to do |format|
      format.html
      format.json do
        payments = Stripe::PaymentIntent.list({ limit: 100 }).data
        data = payments.map do |payment|
          PaymentSerializer.new(payment).serializable_hash
        end

        render json: data
      end
    end
  end
end
