# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payments::CheckoutSessionMailer do
  describe '#completed' do
    let(:mail) { described_class.completed('customer@example.com') }

    it 'sends to the specified email' do
      expect(mail.to).to include('customer@example.com')
    end

    it 'renders the headers' do
      expect(mail.subject).to be_present
      expect(mail.from).to be_present
    end
  end
end
