# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::PostulationApprovedJob do
  let(:job) { described_class.new }
  let(:postulation) { create(:postulation, :approved) }

  describe '#perform' do
    it 'calls Twilio SMS service' do
      sms_service = instance_double(Twilio::SmsService, call: true)
      allow(Twilio::SmsService).to receive(:new).and_return(sms_service)

      job.perform(postulation.id)

      expect(Twilio::SmsService).to have_received(:new)
      expect(sms_service).to have_received(:call)
    end

    it 'does not raise when postulation exists' do
      allow_any_instance_of(Twilio::SmsService).to receive(:call)

      expect { job.perform(postulation.id) }.not_to raise_error
    end
  end
end
