# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentSerializer, type: :serializer do
  let(:payment_data) do
    {
      'id' => 'pi_123',
      'amount_received' => 999,
      'customer' => 'cus_abc',
      'status' => 'succeeded',
      'created' => Time.current.to_i
    }
  end
  let(:serializer) { described_class.new(payment_data) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes stripe_id, amount, candidate_email, status, created_at' do
      expect(attributes).to include(
        :stripe_id,
        :amount,
        :candidate_email,
        :status,
        :created_at
      )
    end

    it 'serializes stripe_id from object id' do
      expect(attributes[:stripe_id]).to eq('pi_123')
    end

    it 'serializes amount by dividing by 100' do
      expect(attributes[:amount]).to eq(9) # 999 / 100 (integer division)
    end

    it 'serializes status as capitalized' do
      expect(attributes[:status]).to eq('Succeeded')
    end
  end
end
