# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiters::JobPostingPolicy, type: :policy do
  subject(:policy) { described_class.new(user, job_posting) }

  let(:job_posting) { create(:job_posting) }
  let(:recruiter) { job_posting.recruiter }

  context 'when user is the job posting owner' do
    let(:user) { recruiter }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'when user is not the job posting owner' do
    let(:user) { create(:recruiter) }

    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end
end
