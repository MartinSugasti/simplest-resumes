# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminSerializer, type: :serializer do
  let(:admin) { create(:admin) }
  let(:serializer) { described_class.new(admin) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, email, role, created_at, admins_invited, invited_by, invitation_accepted' do
      expect(attributes).to include(
        :id,
        :email,
        :role,
        :created_at,
        :admins_invited,
        :invited_by,
        :invitation_accepted
      )
    end

    it 'serializes email correctly' do
      expect(attributes[:email]).to eq(admin.email)
    end

    it 'serializes admins_invited as count' do
      expect(attributes[:admins_invited]).to eq(admin.invitations.count)
    end
  end
end
