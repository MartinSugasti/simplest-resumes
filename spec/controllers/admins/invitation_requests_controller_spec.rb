# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::InvitationRequestsController do
  let(:admin) { create(:admin) }

  describe 'GET #new' do
    it 'returns success when not signed in' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { invitation_request: { email: 'newuser@example.com' } } }

    context 'with valid params' do
      it 'creates an invitation request' do
        expect do
          post :create, params: valid_params
        end.to change(InvitationRequest, :count).by(1)
      end

      it 'enqueues the mailer' do
        expect do
          post :create, params: valid_params
        end.to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end
    end

    context 'with duplicate email' do
      before { create(:invitation_request, email: 'duplicate@example.com') }

      it 'does not create a duplicate' do
        expect do
          post :create, params: { invitation_request: { email: 'duplicate@example.com' } }
        end.not_to change(InvitationRequest, :count)
      end
    end
  end

  describe 'GET #index' do
    before { sign_in admin }

    it 'returns success for html' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns json with invitation requests' do
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(response.parsed_body).to be_an(Array)
    end
  end

  describe 'POST #dismiss' do
    let(:invitation_request) { create(:invitation_request) }

    before { sign_in admin }

    it 'updates status to dismissed' do
      post :dismiss, params: { id: invitation_request.id }, format: :json
      expect(response).to have_http_status(:ok)
      expect(invitation_request.reload.status).to eq('dismissed')
    end
  end

  describe 'POST #ban' do
    let(:invitation_request) { create(:invitation_request) }

    before { sign_in admin }

    it 'updates status to banned' do
      post :ban, params: { id: invitation_request.id }, format: :json
      expect(response).to have_http_status(:ok)
      expect(invitation_request.reload.status).to eq('banned')
    end
  end
end
