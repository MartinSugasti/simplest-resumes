# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::DashboardController do
  let(:admin) { create(:admin) }

  describe 'GET #show' do
    context 'when authenticated' do
      before { sign_in admin }

      it 'returns success' do
        get :show
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not authenticated' do
      it 'redirects to sign in' do
        get :show
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
