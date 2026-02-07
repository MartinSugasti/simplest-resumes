# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiters::ResumesController do
  let(:recruiter) { create(:recruiter) }
  let(:resume) { create(:resume) }

  before { sign_in recruiter }

  describe 'GET #show' do
    it 'returns json with resume' do
      get :show, params: { id: resume.id }, format: :json
      expect(response).to have_http_status(:success)
      expect(response.parsed_body['id']).to eq(resume.id)
    end
  end
end
