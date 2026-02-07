# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::RemindInvitationsJob do
  let(:job) { described_class.new }

  describe '#perform' do
    context 'when there are admins with pending invitations' do
      let!(:admin) { create(:admin, :unconfirmed) }

      before do
        allow(Admin).to receive(:invitation_not_accepted).and_return(Admin.where(id: admin.id))
      end

      it 'enqueues reminder emails for each admin' do
        expect do
          job.perform
        end.to have_enqueued_job(ActionMailer::MailDeliveryJob).at_least(:once)
      end
    end

    context 'when there are no admins with pending invitations' do
      before do
        allow(Admin).to receive(:invitation_not_accepted).and_return(Admin.none)
      end

      it 'does not raise an error' do
        expect { job.perform }.not_to raise_error
      end
    end
  end
end
