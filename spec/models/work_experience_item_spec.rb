# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkExperienceItem do
  describe 'associations' do
    it { is_expected.to belong_to(:resume) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_length_of(:position).is_at_most(40) }
    it { is_expected.to validate_presence_of(:company) }
    it { is_expected.to validate_length_of(:company).is_at_most(40) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_length_of(:location).is_at_most(40) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
