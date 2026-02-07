# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::ResumePolicy, type: :policy do
  subject(:policy) { described_class.new(user, resume) }

  let(:resume) { create(:resume) }
  let(:candidate) { resume.candidate }

  context 'when user is the resume owner' do
    let(:user) { candidate }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'when user is not the resume owner' do
    let(:user) { create(:candidate) }

    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end
end
