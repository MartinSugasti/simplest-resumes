# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::MasqueradePolicy, type: :policy do
  subject(:policy) { described_class.new(user, nil) }

  context 'when user is super_admin' do
    let(:user) { create(:admin) }

    it { is_expected.to permit_action(:masquerade) }
  end

  context 'when user is collaborator' do
    let(:user) { create(:admin, :collaborator) }

    it { is_expected.to forbid_action(:masquerade) }
  end

  context 'when user is not an admin' do
    let(:user) { create(:candidate) }

    it { is_expected.to forbid_action(:masquerade) }
  end
end
