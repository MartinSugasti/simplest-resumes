# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::SkillItemsController do
  let(:candidate) { create(:candidate) }
  let(:resume) { create(:resume, candidate: candidate) }

  before { sign_in candidate }

  describe 'POST #create' do
    let(:valid_params) do
      {
        skill_item: {
          name: 'Ruby',
          kind: 'primary',
          resume_id: resume.id
        }
      }
    end

    it 'creates a skill item' do
      expect do
        post :create, params: valid_params
      end.to change(SkillItem, :count).by(1)
    end

    it 'returns json with id on success' do
      post :create, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to be_present
    end
  end

  describe 'DELETE #destroy' do
    let!(:skill_item) { create(:skill_item, resume: resume) }

    it 'destroys the skill item' do
      expect do
        delete :destroy, params: { id: skill_item.id }
      end.to change(SkillItem, :count).by(-1)
    end
  end
end
