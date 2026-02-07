# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Twilio::SmsService do
  let(:body) { 'Test message' }
  let(:to_phone) { '+1234567890' }

  describe '#call' do
    let(:twilio_client) { instance_double(Twilio::REST::Client) }
    let(:messages) { instance_double(Twilio::REST::Api::V2010::AccountContext::MessageList) }

    before do
      allow(Twilio::REST::Client).to receive(:new).and_return(twilio_client)
      allow(twilio_client).to receive(:messages).and_return(messages)
      allow(messages).to receive(:create).and_return(double(sid: 'SM123'))
    end

    it 'creates and sends an SMS message' do
      service = described_class.new(body, to_phone)
      service.call

      expect(messages).to have_received(:create)
    end
  end
end
