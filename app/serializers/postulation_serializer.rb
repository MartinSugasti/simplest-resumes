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
class PostulationSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes :id, :status
  belongs_to :candidate

  def status
    ApplicationHelper.translate_enum_value('postulation', 'statuses', object.status)
  end
end
