# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::JobPostingsController do
  let(:candidate) { create(:candidate) }

  before { sign_in candidate }

  describe 'GET #index' do
    it 'returns success for html' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns json with published job postings when no query' do
      create(:job_posting, published: true)
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(response.parsed_body).to be_an(Array)
    end

    it 'returns json with query results when valid query' do
      allow_any_instance_of(OpenAi::JobPostingsSqlService).to receive(:valid?).and_return(true)
      allow_any_instance_of(OpenAi::JobPostingsSqlService).to receive(:process)
      allow_any_instance_of(OpenAi::JobPostingsSqlService).to receive(:safe?).and_return(true)
      allow_any_instance_of(OpenAi::JobPostingsSqlService).to receive(:sql_query).and_return(
        'SELECT * FROM job_postings WHERE published = true LIMIT 50'
      )

      get :index, params: { query: 'Ruby jobs' }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:job_posting) { create(:job_posting, published: true) }

    it 'returns success for html' do
      get :show, params: { id: job_posting.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns json with job posting' do
      get :show, params: { id: job_posting.id }, format: :json
      expect(response).to have_http_status(:success)
      expect(response.parsed_body['id']).to eq(job_posting.id)
    end
  end
end
