# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::PostulationsController do
  let(:candidate) { create(:candidate, :with_subscription) }
  let(:job_posting) { create(:job_posting, published: true) }

  before { sign_in candidate }

  describe 'POST #create' do
    let(:valid_params) { { postulation: { job_posting_id: job_posting.id } } }

    it 'creates a postulation' do
      expect do
        post :create, params: valid_params
      end.to change(Postulation, :count).by(1)
    end

    it 'returns ok on success' do
      post :create, params: valid_params
      expect(response).to have_http_status(:ok)
    end

    context 'when job posting already has postulation from candidate' do
      before { create(:postulation, candidate: candidate, job_posting: job_posting) }

      it 'returns unprocessable entity' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
