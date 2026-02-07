# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalLinkItem do
  describe 'associations' do
    it { is_expected.to belong_to(:resume) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(40) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_length_of(:url).is_at_most(80) }
  end
end
