# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobPostingSerializer, type: :serializer do
  let(:job_posting) { create(:job_posting) }
  let(:scope) { double('scope', recruiter?: false, candidate?: false, id: nil) }
  let(:serializer) { described_class.new(job_posting, scope: scope) }

  describe 'attributes' do
    subject(:attributes) { serializer.serializable_hash }

    it 'includes id, title, company, skills, description, created_at' do
      expect(attributes).to include(
        :id,
        :title,
        :company,
        :skills,
        :description,
        :created_at
      )
    end

    it 'serializes title correctly' do
      expect(attributes[:title]).to eq(job_posting.title)
    end

    it 'serializes company correctly' do
      expect(attributes[:company]).to eq(job_posting.company)
    end
  end
end
