# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactFormController do
  describe 'POST #create' do
    let(:valid_params) do
      {
        contact_form: {
          name: 'John Doe',
          email: 'john@example.com',
          mobile: '+1234567890',
          query: 'Test message',
          recaptcha: 'valid_token'
        }
      }
    end

    context 'when recaptcha is valid' do
      before do
        allow_any_instance_of(Google::RecaptchaService).to receive(:verify).and_return(true)
      end

      it 'returns success' do
        post :create, params: valid_params
        expect(response).to have_http_status(:success)
      end

      it 'enqueues the contact form mailer' do
        expect do
          post :create, params: valid_params
        end.to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end

      it 'returns success message' do
        post :create, params: valid_params
        expect(response.body).to be_present
      end
    end

    context 'when recaptcha is invalid' do
      before do
        allow_any_instance_of(Google::RecaptchaService).to receive(:verify).and_return(false)
      end

      it 'returns unprocessable entity' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not enqueue the mailer' do
        expect do
          post :create, params: valid_params
        end.not_to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end
    end
  end
end
