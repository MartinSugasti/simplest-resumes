# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::ExternalLinkItemsController do
  let(:candidate) { create(:candidate) }
  let(:resume) { create(:resume, candidate: candidate) }

  before { sign_in candidate }

  describe 'POST #create' do
    let(:valid_params) do
      {
        external_link_item: {
          name: 'LinkedIn',
          url: 'https://linkedin.com/in/example',
          resume_id: resume.id
        }
      }
    end

    it 'creates an external link item' do
      expect do
        post :create, params: valid_params
      end.to change(ExternalLinkItem, :count).by(1)
    end

    it 'returns json with id on success' do
      post :create, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end
  end

  describe 'DELETE #destroy' do
    let!(:external_link_item) { create(:external_link_item, resume: resume) }

    it 'destroys the external link item' do
      expect do
        delete :destroy, params: { id: external_link_item.id }
      end.to change(ExternalLinkItem, :count).by(-1)
    end
  end
end
