# frozen_string_literal: true

# == Schema Information
#
# Table name: education_items
#
#  id         :bigint           not null, primary key
#  end_year   :integer
#  institute  :string(40)       not null
#  name       :string(40)       not null
#  start_year :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  resume_id  :bigint           not null
#
# Indexes
#
#  index_education_items_on_resume_id  (resume_id)
#
# Foreign Keys
#
#  fk_rails_...  (resume_id => resumes.id)
#
class EducationItem < ApplicationRecord
  belongs_to :resume

  delegate :candidate, to: :resume

  validates :name, presence: true, length: { maximum: 40 }
  validates :institute, presence: true, length: { maximum: 40 }
  validates :start_year, presence: true, numericality: { only_integer: true, in: 1900..2100 }
  validates :end_year, presence: true, allow_nil: true, numericality: {
    only_integer: true, in: 1900..2100, greater_than_or_equal_to: ->(item) { item.start_year }
  }

  validates_with ResumeAssociationsCountValidator
end
