# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::RecaptchaService do
  describe '#verify' do
    let(:token) { 'valid_recaptcha_token' }

    context 'when verification succeeds' do
      before do
        stub_request(:get, %r{www\.google\.com/recaptcha/api/siteverify})
          .to_return(body: { success: true }.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns true' do
        expect(described_class.new(token).verify).to be true
      end
    end

    context 'when verification fails' do
      before do
        stub_request(:get, %r{www\.google\.com/recaptcha/api/siteverify})
          .to_return(body: { success: false }.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns false' do
        expect(described_class.new(token).verify).to be false
      end
    end
  end
end
