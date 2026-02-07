# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecruiterSerializer, type: :serializer do
  let(:recruiter) { create(:recruiter) }
  let(:serializer) { described_class.new(recruiter) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, email, created_at, confirmed?, sign_in_path' do
      expect(attributes).to include(
        :id,
        :email,
        :created_at,
        :confirmed?,
        :sign_in_path
      )
    end

    it 'serializes email correctly' do
      expect(attributes[:email]).to eq(recruiter.email)
    end

    it 'includes profile_picture_url' do
      expect(attributes).to have_key(:profile_picture_url)
    end
  end
end
