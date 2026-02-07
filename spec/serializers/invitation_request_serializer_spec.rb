# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitationRequestSerializer, type: :serializer do
  let(:invitation_request) { create(:invitation_request) }
  let(:serializer) { described_class.new(invitation_request) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, email, status, invited_as, created_at' do
      expect(attributes).to include(
        :id,
        :email,
        :status,
        :invited_as,
        :created_at
      )
    end

    it 'serializes email correctly' do
      expect(attributes[:email]).to eq(invitation_request.email)
    end

    it 'serializes invited_as as hyphen when not approved' do
      invitation_request.update!(status: :pending)
      expect(serializer.serializable_hash[:invited_as]).to eq('-')
    end
  end
end
