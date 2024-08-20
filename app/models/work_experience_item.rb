# frozen_string_literal: true

# == Schema Information
#
# Table name: work_experience_items
#
#  id          :bigint           not null, primary key
#  company     :string(40)       not null
#  description :text             not null
#  end_month   :integer
#  end_year    :integer
#  location    :string(40)       not null
#  position    :string(40)       not null
#  start_month :integer          not null
#  start_year  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resume_id   :bigint           not null
#
# Indexes
#
#  index_work_experience_items_on_resume_id  (resume_id)
#
# Foreign Keys
#
#  fk_rails_...  (resume_id => resumes.id)
#
class WorkExperienceItem < ApplicationRecord
  belongs_to :resume

  delegate :candidate, to: :resume

  validates :position, presence: true, length: { maximum: 40 }
  validates :company, presence: true, length: { maximum: 40 }
  validates :location, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 800 }
  validates :start_month, presence: true, numericality: { only_integer: true, in: 1..12 }
  validates :start_year, presence: true, numericality: { only_integer: true, in: 1900..2100 }
  validates :end_month, presence: true, numericality: {
    only_integer: true, in: 1..12, greater_than_or_equal_to: lambda do |item|
      item.start_year == item.end_year ? item.start_month : 1
    end
  }, if: ->(item) { item.end_year.present? }
  validates :end_year, presence: true, numericality: {
    only_integer: true, in: 1900..2100, greater_than_or_equal_to: ->(item) { item.start_year }
  }, if: ->(item) { item.end_month.present? }

  validates_with ResumeAssociationsCountValidator, on: :create
end
