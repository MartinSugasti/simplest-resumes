# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiter do
  describe 'associations' do
    it { is_expected.to have_many(:job_postings).dependent(:destroy) }
  end

  describe '#from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'github',
        info: { email: 'recruiter_oauth@example.com' }
      )
    end

    it 'creates a new recruiter when one does not exist' do
      expect do
        described_class.from_omniauth(auth)
      end.to change(described_class, :count).by(1)
    end

    it 'finds existing recruiter by email' do
      existing = create(:recruiter, email: 'recruiter_oauth@example.com')
      result = described_class.from_omniauth(auth)
      expect(result).to eq(existing)
    end
  end
end
