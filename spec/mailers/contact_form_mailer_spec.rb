# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactFormMailer do
  describe '#new_request' do
    let(:mail) do
      described_class.new_request(
        'John Doe',
        'john@example.com',
        '+1234567890',
        'Test query message'
      )
    end

    before { create(:admin) }

    it 'renders the headers' do
      expect(mail.subject).to be_present
      expect(mail.to).to be_present
      expect(mail.from).to be_present
    end

    it 'sets the reply_to to the contact email' do
      expect(mail.reply_to).to include('john@example.com')
    end

    it 'assigns instance variables' do
      expect(mail.body.encoded).to include('John Doe')
      expect(mail.body.encoded).to include('john@example.com')
      expect(mail.body.encoded).to include('Test query message')
    end
  end
end
