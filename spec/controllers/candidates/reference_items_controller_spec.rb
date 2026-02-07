# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::ReferenceItemsController do
  let(:candidate) { create(:candidate) }
  let(:resume) { create(:resume, candidate: candidate) }

  before { sign_in candidate }

  describe 'POST #create' do
    let(:valid_params) do
      {
        reference_item: {
          name: 'Jane Doe',
          mobile: '+1234567890',
          company: 'Acme Inc',
          position: 'Manager',
          kind: 'personal',
          resume_id: resume.id
        }
      }
    end

    it 'creates a reference item' do
      expect do
        post :create, params: valid_params
      end.to change(ReferenceItem, :count).by(1)
    end

    it 'returns json with id on success' do
      post :create, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end
  end

  describe 'DELETE #destroy' do
    let!(:reference_item) { create(:reference_item, resume: resume) }

    it 'destroys the reference item' do
      expect do
        delete :destroy, params: { id: reference_item.id }
      end.to change(ReferenceItem, :count).by(-1)
    end
  end
end
