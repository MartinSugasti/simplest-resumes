# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SkillItemSerializer, type: :serializer do
  let(:skill_item) { create(:skill_item) }
  let(:serializer) { described_class.new(skill_item) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id and name' do
      expect(attributes).to include(:id, :name)
    end

    it 'serializes name correctly' do
      expect(attributes[:name]).to eq(skill_item.name)
    end
  end
end
