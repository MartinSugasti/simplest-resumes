# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::MyResumeController do
  let(:candidate) { create(:candidate) }

  before { sign_in candidate }

  describe 'GET #show' do
    it 'returns success for html' do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'returns json with resume' do
      resume = create(:resume, candidate: candidate)
      get :show, format: :json
      expect(response).to have_http_status(:success)
      expect(response.parsed_body['id']).to eq(resume.id)
    end

    it 'creates resume if none exists' do
      expect do
        get :show, format: :json
      end.to change(Resume, :count).by(1)
    end
  end

  describe 'PATCH #update' do
    before { create(:resume, candidate: candidate) }

    let(:valid_params) do
      { resume: { name: 'Updated Name', email: 'updated@example.com' } }
    end

    it 'returns ok on success' do
      patch :update, params: valid_params
      expect(response).to have_http_status(:ok)
    end

    it 'updates the resume' do
      patch :update, params: valid_params
      expect(candidate.resume.reload.name).to eq('Updated Name')
    end
  end
end
