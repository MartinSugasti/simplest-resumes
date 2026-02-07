# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitationRequest do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:status) }

    it 'validates uniqueness of email' do
      create(:invitation_request, email: 'test@example.com')
      duplicate = build(:invitation_request, email: 'test@example.com')
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:email]).to be_present
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, approved: 1, dismissed: 2, banned: 3) }
  end
end
