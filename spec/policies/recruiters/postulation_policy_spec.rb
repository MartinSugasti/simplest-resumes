# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiters::PostulationPolicy, type: :policy do
  subject(:policy) { described_class.new(user, postulation) }

  let(:postulation) { create(:postulation) }
  let(:recruiter) { postulation.recruiter }

  context 'when user is the job posting recruiter' do
    let(:user) { recruiter }

    it { is_expected.to permit_action(:approve) }
    it { is_expected.to permit_action(:reject) }
  end

  context 'when user is not the job posting recruiter' do
    let(:user) { create(:recruiter) }

    it { is_expected.to forbid_action(:approve) }
    it { is_expected.to forbid_action(:reject) }
  end
end
