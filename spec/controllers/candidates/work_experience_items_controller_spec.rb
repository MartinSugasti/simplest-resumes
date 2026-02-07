# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::WorkExperienceItemsController do
  let(:candidate) { create(:candidate) }
  let(:resume) { create(:resume, candidate: candidate) }

  before { sign_in candidate }

  describe 'POST #create' do
    let(:valid_params) do
      {
        work_experience_item: {
          position: 'Developer',
          company: 'Tech Corp',
          location: 'NYC',
          description: 'Built things',
          start_month: 1,
          start_year: 2020,
          resume_id: resume.id
        }
      }
    end

    it 'creates a work experience item' do
      expect do
        post :create, params: valid_params
      end.to change(WorkExperienceItem, :count).by(1)
    end

    it 'returns json with id on success' do
      post :create, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end
  end

  describe 'DELETE #destroy' do
    let!(:work_experience_item) { create(:work_experience_item, resume: resume) }

    it 'destroys the work experience item' do
      expect do
        delete :destroy, params: { id: work_experience_item.id }
      end.to change(WorkExperienceItem, :count).by(-1)
    end
  end
end
