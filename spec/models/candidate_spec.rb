# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidate do
  describe 'associations' do
    it { is_expected.to have_one(:resume).dependent(:destroy) }
    it { is_expected.to have_many(:postulations).dependent(:destroy) }
    it { is_expected.to have_many(:job_postings).through(:postulations) }
  end

  describe 'scopes' do
    describe '.confirmed' do
      let!(:confirmed_candidate) { create(:candidate, confirmed_at: Time.current) }
      let!(:unconfirmed_candidate) { create(:candidate, :unconfirmed) }

      it 'returns only confirmed candidates' do
        expect(described_class.confirmed).to include(confirmed_candidate)
        expect(described_class.confirmed).not_to include(unconfirmed_candidate)
      end
    end
  end

  describe '#active_subscription?' do
    let(:candidate) { create(:candidate) }

    it 'returns false when subscription_ends_at is nil' do
      candidate.update!(subscription_ends_at: nil)
      expect(candidate.active_subscription?).to be false
    end

    it 'returns false when subscription has expired' do
      candidate.update!(subscription_ends_at: 1.day.ago)
      expect(candidate.active_subscription?).to be false
    end

    it 'returns true when subscription is active' do
      candidate.update!(subscription_ends_at: 1.day.from_now)
      expect(candidate.active_subscription?).to be true
    end
  end

  describe '#from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'github',
        info: { email: 'oauth@example.com' }
      )
    end

    it 'creates a new candidate when one does not exist' do
      expect do
        described_class.from_omniauth(auth)
      end.to change(described_class, :count).by(1)
    end

    it 'finds existing candidate by email' do
      existing = create(:candidate, email: 'oauth@example.com')
      result = described_class.from_omniauth(auth)
      expect(result).to eq(existing)
    end
  end
end
