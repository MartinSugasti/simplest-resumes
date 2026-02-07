# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EducationItemSerializer, type: :serializer do
  let(:education_item) { create(:education_item) }
  let(:serializer) { described_class.new(education_item) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, name, institute, start_year, end_year' do
      expect(attributes).to include(
        :id,
        :name,
        :institute,
        :start_year,
        :end_year
      )
    end

    it 'serializes name correctly' do
      expect(attributes[:name]).to eq(education_item.name)
    end

    it 'serializes institute correctly' do
      expect(attributes[:institute]).to eq(education_item.institute)
    end
  end
end
