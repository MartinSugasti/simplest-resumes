# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::EducationItemsController do
  let(:candidate) { create(:candidate) }
  let(:resume) { create(:resume, candidate: candidate) }

  before { sign_in candidate }

  describe 'POST #create' do
    let(:valid_params) do
      {
        education_item: {
          name: 'Computer Science',
          institute: 'MIT',
          start_year: 2018,
          end_year: 2022,
          resume_id: resume.id
        }
      }
    end

    it 'creates an education item' do
      expect do
        post :create, params: valid_params
      end.to change(EducationItem, :count).by(1)
    end

    it 'returns json with id on success' do
      post :create, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end

    context 'when resume belongs to another candidate' do
      let(:other_resume) { create(:resume) }

      it 'forbids the action' do
        post :create, params: {
          education_item: {
            name: 'CS',
            institute: 'MIT',
            start_year: 2018,
            end_year: 2022,
            resume_id: other_resume.id
          }
        }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:education_item) { create(:education_item, resume: resume) }

    it 'destroys the education item' do
      expect do
        delete :destroy, params: { id: education_item.id }
      end.to change(EducationItem, :count).by(-1)
    end

    it 'returns ok on success' do
      delete :destroy, params: { id: education_item.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
