# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkExperienceItemSerializer, type: :serializer do
  let(:work_experience_item) { create(:work_experience_item) }
  let(:serializer) { described_class.new(work_experience_item) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, company, description, position, location, start_month, start_year' do
      expect(attributes).to include(
        :id,
        :company,
        :description,
        :position,
        :location,
        :start_month,
        :start_year
      )
    end

    it 'includes end_month and end_year' do
      expect(attributes).to include(:end_month, :end_year)
    end

    it 'serializes position correctly' do
      expect(attributes[:position]).to eq(work_experience_item.position)
    end

    it 'serializes company correctly' do
      expect(attributes[:company]).to eq(work_experience_item.company)
    end
  end
end
