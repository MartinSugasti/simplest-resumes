# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiters::CandidatesController do
  let(:recruiter) { create(:recruiter) }

  before { sign_in recruiter }

  describe 'GET #index' do
    it 'returns success for html' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns json with candidates when no query' do
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(response.parsed_body).to be_an(Array)
    end

    it 'returns json with query results when valid query' do
      allow_any_instance_of(OpenAi::CandidatesSqlService).to receive(:valid?).and_return(true)
      allow_any_instance_of(OpenAi::CandidatesSqlService).to receive(:process)
      allow_any_instance_of(OpenAi::CandidatesSqlService).to receive(:safe?).and_return(true)
      allow_any_instance_of(OpenAi::CandidatesSqlService).to receive(:sql_query).and_return(
        'SELECT * FROM candidates LIMIT 50'
      )

      get :index, params: { query: 'marketing experience' }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:candidate) { create(:candidate) }

    it 'returns success for html' do
      get :show, params: { id: candidate.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns json with candidate' do
      get :show, params: { id: candidate.id }, format: :json
      expect(response).to have_http_status(:success)
      expect(response.parsed_body['id']).to eq(candidate.id)
    end
  end
end
