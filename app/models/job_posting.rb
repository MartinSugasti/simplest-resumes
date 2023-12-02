# frozen_string_literal: true

# == Schema Information
#
# Table name: job_postings
#
#  id           :bigint           not null, primary key
#  company      :string(40)       not null
#  description  :text             not null
#  published    :boolean          default(FALSE), not null
#  skills       :string(80)       not null
#  title        :string(40)       not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recruiter_id :bigint           not null
#
# Indexes
#
#  index_job_postings_on_recruiter_id  (recruiter_id)
#
# Foreign Keys
#
#  fk_rails_...  (recruiter_id => recruiters.id)
#
class JobPosting < ApplicationRecord
  belongs_to :recruiter

  validates :title, length: { maximum: 40 }
  validates :company, length: { maximum: 40 }
  validates :skills, length: { maximum: 80 }
  validates :description, length: { maximum: 800 }
  validates :published, inclusion: [true, false]

  scope :published, -> { where(published: true) }
end
