# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResumeAssociationsCountValidator, type: :validator do
  let(:resume) { create(:resume) }

  describe 'SkillItem' do
    before do
      5.times { create(:skill_item, resume: resume) }
    end

    it 'adds error when exceeding maximum primary skill items' do
      skill_item = build(:skill_item, resume: resume)
      expect(skill_item).not_to be_valid
      expect(skill_item.errors[:base]).to be_present
    end

    it 'allows creation when under the limit' do
      resume_with_few_skills = create(:resume)
      skill_item = build(:skill_item, resume: resume_with_few_skills)
      expect(skill_item).to be_valid
    end
  end

  describe 'ReferenceItem' do
    before do
      4.times { create(:reference_item, resume: resume, kind: :personal) }
    end

    it 'adds error when exceeding maximum personal reference items' do
      reference_item = build(:reference_item, resume: resume, kind: :personal)
      expect(reference_item).not_to be_valid
      expect(reference_item.errors[:base]).to be_present
    end
  end
end
