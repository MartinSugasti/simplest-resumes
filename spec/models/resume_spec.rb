# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resume do
  describe 'associations' do
    it { is_expected.to belong_to(:candidate) }
    it { is_expected.to have_many(:education_items).dependent(:destroy) }
    it { is_expected.to have_many(:work_experience_items).dependent(:destroy) }
    it { is_expected.to have_many(:external_link_items).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_most(40) }
    it { is_expected.to validate_length_of(:email).is_at_most(40) }
    it { is_expected.to validate_length_of(:mobile).is_at_most(20) }
    it { is_expected.to validate_length_of(:location).is_at_most(40) }
    it { is_expected.to validate_length_of(:about_me).is_at_most(2000) }

    describe 'education_items maximum' do
      it 'allows up to 5 education items' do
        resume = create(:resume)
        create_list(:education_item, 5, resume: resume)
        expect(resume.reload).to be_valid
      end

      it 'rejects more than 5 education items' do
        resume = build(:resume)
        6.times { resume.education_items.build(attributes_for(:education_item)) }
        expect(resume).not_to be_valid
        expect(resume.errors[:education_items]).to be_present
      end
    end

    describe 'work_experience_items maximum' do
      it 'allows up to 5 work experience items' do
        resume = create(:resume)
        create_list(:work_experience_item, 5, resume: resume)
        expect(resume.reload).to be_valid
      end

      it 'rejects more than 5 work experience items' do
        resume = build(:resume)
        6.times { resume.work_experience_items.build(attributes_for(:work_experience_item)) }
        expect(resume).not_to be_valid
        expect(resume.errors[:work_experience_items]).to be_present
      end
    end
  end
end
