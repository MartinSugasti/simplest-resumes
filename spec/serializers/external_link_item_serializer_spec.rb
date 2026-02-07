# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalLinkItemSerializer, type: :serializer do
  let(:external_link_item) { create(:external_link_item) }
  let(:serializer) { described_class.new(external_link_item) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, name, url' do
      expect(attributes).to include(:id, :name, :url)
    end

    it 'serializes name correctly' do
      expect(attributes[:name]).to eq(external_link_item.name)
    end

    it 'serializes url correctly' do
      expect(attributes[:url]).to eq(external_link_item.url)
    end
  end
end
