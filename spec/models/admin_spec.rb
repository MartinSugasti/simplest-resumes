# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin do
  describe 'associations' do
    it { is_expected.to have_many(:invitations).class_name('Admin') }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(super_admin: 0, collaborator: 1) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
end
