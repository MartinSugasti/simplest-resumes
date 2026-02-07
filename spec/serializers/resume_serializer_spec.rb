# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResumeSerializer, type: :serializer do
  let(:resume) { create(:resume) }
  let(:serializer) { described_class.new(resume) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, name, email, mobile, location, about_me' do
      expect(attributes).to include(
        :id,
        :name,
        :email,
        :mobile,
        :location,
        :about_me
      )
    end

    it 'serializes name correctly' do
      expect(attributes[:name]).to eq(resume.name)
    end

    it 'serializes email correctly' do
      expect(attributes[:email]).to eq(resume.email)
    end
  end
end
