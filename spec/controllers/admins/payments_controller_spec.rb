# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::PaymentsController do
  let(:admin) { create(:admin) }

  before { sign_in admin }

  describe 'GET #index' do
    it 'returns success for html' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns json with payments' do
      payment_data = {
        'id' => 'pi_123',
        'amount_received' => 999,
        'customer' => 'cus_abc',
        'status' => 'succeeded',
        'created' => Time.current.to_i
      }
      allow(Stripe::PaymentIntent).to receive(:list).and_return(
        double(data: [payment_data])
      )

      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include('application/json')
    end
  end
end
