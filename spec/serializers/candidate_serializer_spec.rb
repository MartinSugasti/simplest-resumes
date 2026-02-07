# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CandidateSerializer, type: :serializer do
  let(:candidate) { create(:candidate) }
  let(:serializer) { described_class.new(candidate, scope: double('scope', admin?: false, recruiter?: false)) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id and email' do
      expect(attributes).to include(:id, :email)
    end

    it 'serializes email correctly' do
      expect(attributes[:email]).to eq(candidate.email)
    end
  end
end
