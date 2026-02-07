# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::RecruitersController do
  let(:admin) { create(:admin) }

  before { sign_in admin }

  describe 'GET #index' do
    it 'returns success for html' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns json with recruiters' do
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include('application/json')
      expect(response.parsed_body).to be_an(Array)
    end
  end
end
