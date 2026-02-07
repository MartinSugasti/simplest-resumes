# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StripeWebhooksController do
  let(:payload) { { id: 'evt_123' }.to_json }
  let(:sig_header) { 'valid_signature' }

  before do
    allow(Stripe::Webhook).to receive(:construct_event).and_return(
      double(type: 'customer.created', data: double(object: double(
        email: 'test@example.com',
        id: 'cus_123'
      )))
    )
  end

  def do_post
    request.env['HTTP_STRIPE_SIGNATURE'] = sig_header
    post :create, body: payload
  end

  describe 'POST #create' do
    context 'with customer.created event' do
      it 'returns ok' do
        do_post
        expect(response).to have_http_status(:ok)
      end

      it 'updates candidate stripe_customer_id when candidate exists' do
        candidate = create(:candidate, email: 'test@example.com')

        do_post

        expect(candidate.reload.stripe_customer_id).to eq('cus_123')
      end
    end

    context 'with checkout.session.completed event' do
      before do
        allow(Stripe::Webhook).to receive(:construct_event).and_return(
          double(
            type: 'checkout.session.completed',
            data: double(object: double(
              customer_details: double(email: 'customer@example.com'),
              metadata: double(customer_email: nil)
            ))
          )
        )
      end

      it 'enqueues checkout session mailer' do
        expect { do_post }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end

      it 'returns ok' do
        do_post
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid payload' do
      before do
        allow(Stripe::Webhook).to receive(:construct_event)
          .and_raise(JSON::ParserError.new('invalid json'))
      end

      it 'returns bad request' do
        do_post
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with invalid signature' do
      before do
        allow(Stripe::Webhook).to receive(:construct_event)
          .and_raise(Stripe::SignatureVerificationError.new('invalid', 'sig'))
      end

      it 'returns bad request' do
        do_post
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
