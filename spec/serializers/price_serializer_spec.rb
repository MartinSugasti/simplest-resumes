# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceSerializer, type: :serializer do
  let(:price_data) do
    {
      'id' => 'price_123',
      'lookup_key' => 'monthly',
      'unit_amount' => 999
    }
  end
  let(:serializer) { described_class.new(price_data) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, lookup_key, unit_amount' do
      expect(attributes).to include(:id, :lookup_key, :unit_amount)
    end

    it 'serializes id correctly' do
      expect(attributes[:id]).to eq('price_123')
    end

    it 'serializes lookup_key correctly' do
      expect(attributes[:lookup_key]).to eq('monthly')
    end

    it 'serializes unit_amount correctly' do
      expect(attributes[:unit_amount]).to eq(999)
    end
  end
end
