# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiters::JobPostingsController do
  let(:recruiter) { create(:recruiter) }
  let(:job_posting) { create(:job_posting, recruiter: recruiter) }

  before { sign_in recruiter }

  describe 'GET #index' do
    it 'returns success for html' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns json with recruiter job postings' do
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(response.parsed_body).to be_an(Array)
    end
  end

  describe 'GET #show' do
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

  describe 'GET #new' do
    it 'returns success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        job_posting: {
          title: 'New Job',
          company: 'New Corp',
          skills: 'Ruby',
          description: 'Great job',
          published: false
        }
      }
    end

    it 'creates a job posting' do
      expect do
        post :create, params: valid_params
      end.to change(JobPosting, :count).by(1)
    end

    it 'returns ok on success' do
      post :create, params: valid_params
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH #update' do
    let(:update_params) do
      { job_posting: { title: 'Updated Title' } }
    end

    it 'updates the job posting' do
      patch :update, params: { id: job_posting.id }.merge(update_params)
      expect(job_posting.reload.title).to eq('Updated Title')
    end

    it 'returns ok on success' do
      patch :update, params: { id: job_posting.id }.merge(update_params)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns ok on success' do
      delete :destroy, params: { id: job_posting.id }
      expect(response).to have_http_status(:ok)
    end

    it 'destroys the job posting' do
      post = create(:job_posting, recruiter: recruiter)
      expect do
        delete :destroy, params: { id: post.id }
      end.to change(JobPosting, :count).by(-1)
    end
  end
end
