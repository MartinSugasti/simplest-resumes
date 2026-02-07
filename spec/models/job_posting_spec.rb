# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobPosting do
  describe 'associations' do
    it { is_expected.to belong_to(:recruiter) }
    it { is_expected.to have_many(:postulations).dependent(:destroy) }
    it { is_expected.to have_many(:candidates).through(:postulations) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:title).is_at_most(40) }
    it { is_expected.to validate_length_of(:company).is_at_most(40) }
    it { is_expected.to validate_length_of(:skills).is_at_most(80) }
    it { is_expected.to validate_length_of(:description).is_at_most(2000) }
  end

  describe 'scopes' do
    describe '.published' do
      let!(:published_posting) { create(:job_posting, published: true) }
      let!(:unpublished_posting) { create(:job_posting, :unpublished) }

      it 'returns only published job postings' do
        expect(described_class.published).to include(published_posting)
        expect(described_class.published).not_to include(unpublished_posting)
      end
    end
  end
end
