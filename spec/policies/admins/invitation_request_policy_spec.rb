# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::InvitationRequestPolicy, type: :policy do
  subject(:policy) { described_class.new(user, nil) }

  let(:invitation_request) { create(:invitation_request) }

  context 'when user is super_admin' do
    let(:user) { create(:admin) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:dismiss) }
    it { is_expected.to permit_action(:ban) }
  end

  context 'when user is collaborator' do
    let(:user) { create(:admin, :collaborator) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:dismiss) }
    it { is_expected.to forbid_action(:ban) }
  end
end
