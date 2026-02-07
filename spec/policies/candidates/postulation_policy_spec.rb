# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::PostulationPolicy, type: :policy do
  subject(:policy) { described_class.new(user, postulation) }

  let(:postulation) { create(:postulation) }
  let(:candidate) { postulation.candidate }

  context 'when user is the postulation owner' do
    let(:user) { candidate }

    it { is_expected.to permit_action(:create) }
  end

  context 'when user is not the postulation owner' do
    let(:user) { create(:candidate) }

    it { is_expected.to forbid_action(:create) }
  end
end
