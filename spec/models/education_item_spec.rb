# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EducationItem do
  describe 'associations' do
    it { is_expected.to belong_to(:resume) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(40) }
    it { is_expected.to validate_presence_of(:institute) }
    it { is_expected.to validate_length_of(:institute).is_at_most(40) }
    it { is_expected.to validate_presence_of(:start_year) }
    it { is_expected.to validate_numericality_of(:start_year).only_integer }
  end
end
