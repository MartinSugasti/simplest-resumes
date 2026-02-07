# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReferenceItem do
  describe 'associations' do
    it { is_expected.to belong_to(:resume) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(40) }
    it { is_expected.to validate_presence_of(:company) }
    it { is_expected.to validate_length_of(:company).is_at_most(40) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_length_of(:position).is_at_most(40) }
    it { is_expected.to validate_presence_of(:mobile) }
    it { is_expected.to validate_length_of(:mobile).is_at_most(20) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:kind).with_values(personal: 0, job: 1) }
  end
end
