# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::SubscriptionsController do
  let(:candidate) { create(:candidate) }

  before { sign_in candidate }

  describe 'GET #index' do
    it 'returns success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #prices' do
    before do
      price_data = { 'id' => 'price_1', 'lookup_key' => 'monthly', 'unit_amount' => 999 }
      price_data.define_singleton_method(:unit_amount) { self['unit_amount'] }
      allow(Stripe::Price).to receive(:list).and_return(
        double(data: [price_data])
      )
    end

    it 'returns json with prices' do
      get :prices, format: :json
      expect(response).to have_http_status(:success)
      json = response.parsed_body
      expect(json).to have_key('prices')
      expect(json).to have_key('subscription_data')
    end
  end

  describe 'POST #create' do
    before do
      candidate.update!(stripe_customer_id: 'cus_123')
      allow(Stripe::Checkout::Session).to receive(:create).and_return(
        double(url: 'https://checkout.stripe.com/session')
      )
    end

    it 'returns json with checkout url' do
      post :create, params: { plan_id: 'price_123' }
      expect(response).to have_http_status(:success)
      expect(response.parsed_body['url']).to eq('https://checkout.stripe.com/session')
    end
  end
end
