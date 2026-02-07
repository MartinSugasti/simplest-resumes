# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostulationSerializer, type: :serializer do
  let(:postulation) { create(:postulation) }
  let(:scope) { double('scope', admin?: false, recruiter?: false) }
  let(:serializer) { described_class.new(postulation, scope: scope) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id and status' do
      expect(attributes).to include(:id, :status)
    end

    it 'serializes id correctly' do
      expect(attributes[:id]).to eq(postulation.id)
    end

    it 'serializes status as translated value' do
      expect(attributes[:status]).to be_present
    end
  end

  describe 'associations' do
    it 'includes candidate' do
      attributes = serializer.serializable_hash
      expect(attributes).to have_key(:candidate)
    end
  end
end
