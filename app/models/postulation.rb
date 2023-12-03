# frozen_string_literal: true

# == Schema Information
#
# Table name: postulations
#
#  id             :bigint           not null, primary key
#  status         :integer          default("pending"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  candidate_id   :bigint           not null
#  job_posting_id :bigint           not null
#
# Indexes
#
#  index_postulations_on_candidate_id                     (candidate_id)
#  index_postulations_on_candidate_id_and_job_posting_id  (candidate_id,job_posting_id) UNIQUE
#  index_postulations_on_job_posting_id                   (job_posting_id)
#
# Foreign Keys
#
#  fk_rails_...  (candidate_id => candidates.id)
#  fk_rails_...  (job_posting_id => job_postings.id)
#
class Postulation < ApplicationRecord
  belongs_to :candidate
  belongs_to :job_posting

  validates :candidate_id, uniqueness: { scope: :job_posting_id }
  validate :job_posting_published, on: :update

  enum status: {
    pending: 0,
    approved: 1,
    rejected: 2
  }

  private

  def job_posting_published
    return if job_posting.published?

    errors.add(:job_posting, 'is not published')
  end
end
