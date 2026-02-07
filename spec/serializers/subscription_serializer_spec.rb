# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionSerializer, type: :serializer do
  let(:candidate) { create(:candidate) }
  let(:serializer) { described_class.new(candidate) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes active and ends_at' do
      expect(attributes).to include(:active, :ends_at)
    end

    it 'serializes active based on active_subscription?' do
      candidate.update!(subscription_ends_at: nil)
      expect(serializer.serializable_hash[:active]).to be false
    end

    it 'serializes ends_at when subscription is active' do
      candidate.update!(subscription_ends_at: 1.month.from_now)
      expect(serializer.serializable_hash[:ends_at]).to be_present
    end
  end
end
