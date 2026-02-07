# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::InvitationsMailer do
  before { create(:admin) }

  describe '#invitation_accepted_email' do
    let(:mail) { described_class.invitation_accepted_email('admin@example.com') }

    it 'renders the headers' do
      expect(mail.subject).to be_present
      expect(mail.from).to be_present
    end

    it 'includes the email in the body' do
      expect(mail.body.encoded).to include('admin@example.com')
    end
  end

  describe '#invitation_requested_email' do
    let(:mail) { described_class.invitation_requested_email('request@example.com') }

    it 'renders the headers' do
      expect(mail.subject).to be_present
      expect(mail.from).to be_present
    end

    it 'includes the email in the body' do
      expect(mail.body.encoded).to include('request@example.com')
    end
  end

  describe '#invitation_reminder_email' do
    let(:admin) { create(:admin, :unconfirmed) }
    let(:mail) { described_class.invitation_reminder_email(admin.id) }

    it 'renders the headers' do
      expect(mail.to).to include(admin.email)
      expect(mail.from).to be_present
    end
  end
end
