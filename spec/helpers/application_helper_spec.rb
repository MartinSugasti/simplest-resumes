# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#show_dashboard_layout' do
    it 'returns false when user is not signed in' do
      without_partial_double_verification do
        allow(helper).to receive(:user_signed_in?).and_return(false)
        expect(helper.show_dashboard_layout).to be false
      end
    end

    it 'returns false when controller is pages' do
      without_partial_double_verification do
        allow(helper).to receive_messages(user_signed_in?: true, controller_name: 'pages')
        expect(helper.show_dashboard_layout).to be false
      end
    end

    it 'returns true when user is signed in and controller is not pages' do
      without_partial_double_verification do
        allow(helper).to receive_messages(user_signed_in?: true, controller_name: 'dashboard')
        expect(helper.show_dashboard_layout).to be true
      end
    end
  end

  describe '#active_sidebar_option?' do
    it 'returns false when controller does not match' do
      allow(helper).to receive_messages(controller_path: 'candidates/dashboard', action_name: 'show')
      result = helper.active_sidebar_option?({ 'recruiters/dashboard' => [] })
      expect(result).to be false
    end

    it 'returns true when controller matches and actions is empty' do
      allow(helper).to receive_messages(controller_path: 'candidates/dashboard', action_name: 'show')
      result = helper.active_sidebar_option?({ 'candidates/dashboard' => [] })
      expect(result).to be true
    end

    it 'returns true when controller and action match' do
      allow(helper).to receive_messages(controller_path: 'candidates/dashboard', action_name: 'show')
      result = helper.active_sidebar_option?({ 'candidates/dashboard' => ['show'] })
      expect(result).to be true
    end

    it 'returns false when controller matches but action does not' do
      allow(helper).to receive_messages(controller_path: 'candidates/dashboard', action_name: 'edit')
      result = helper.active_sidebar_option?({ 'candidates/dashboard' => ['show'] })
      expect(result).to be false
    end
  end

  describe '#omniauth_authorize_path_for' do
    let(:candidate) { build(:candidate) }

    it 'returns the correct omniauth path for the resource' do
      allow(helper).to receive(:candidate_github_omniauth_authorize_path).and_return('/auth/github')
      expect(helper.omniauth_authorize_path_for(candidate, :github)).to eq('/auth/github')
    end
  end

  describe '#translate_enum_value' do
    it 'translates the enum value' do
      result = described_class.translate_enum_value('admin', 'role', 'super_admin')
      expect(result).to be_present
    end
  end
end
