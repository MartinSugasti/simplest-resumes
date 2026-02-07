# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SkillItem do
  describe 'associations' do
    it { is_expected.to belong_to(:resume) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(40) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:kind).with_values(primary: 0, secondary: 1) }
  end
end
