# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Postulation do
  describe 'associations' do
    it 'belongs to candidate' do
      postulation = build(:postulation)
      expect(postulation.candidate).to be_present
      expect(postulation).to respond_to(:candidate_id)
    end

    it 'belongs to job_posting' do
      postulation = build(:postulation)
      expect(postulation.job_posting).to be_present
      expect(postulation).to respond_to(:job_posting_id)
    end
  end

  describe 'validations' do
    it 'validates uniqueness of candidate per job posting' do
      postulation = create(:postulation)
      duplicate = build(:postulation, candidate: postulation.candidate, job_posting: postulation.job_posting)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:candidate_id]).to be_present
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, approved: 1, rejected: 2) }
  end

  describe 'validates job_posting is published' do
    let(:job_posting) { create(:job_posting, :unpublished) }
    let(:candidate) { create(:candidate, :with_subscription) }

    it 'adds error when job posting is not published' do
      postulation = build(:postulation, candidate: candidate, job_posting: job_posting)
      expect(postulation).not_to be_valid
      expect(postulation.errors[:job_posting]).to be_present
    end
  end
end
