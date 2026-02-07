# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReferenceItemSerializer, type: :serializer do
  let(:reference_item) { create(:reference_item) }
  let(:serializer) { described_class.new(reference_item) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, company, mobile, name, position' do
      expect(attributes).to include(
        :id,
        :company,
        :mobile,
        :name,
        :position
      )
    end

    it 'serializes name correctly' do
      expect(attributes[:name]).to eq(reference_item.name)
    end

    it 'serializes company correctly' do
      expect(attributes[:company]).to eq(reference_item.company)
    end
  end
end
