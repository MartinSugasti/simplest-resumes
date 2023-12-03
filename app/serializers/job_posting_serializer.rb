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
class JobPostingSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes :id, :title, :company, :skills, :description, :published, :created_at
  attribute :published, if: -> { scope.recruiter? }
  attribute :postulation_id, if: -> { scope.candidate? }
  attribute :postulation_status, if: -> { scope.candidate? }

  def created_at
    "#{time_ago_in_words(object.created_at)} ago"
  end

  def postulation_id
    object.postulations.find_by(candidate_id: scope.id)&.id
  end

  def postulation_status
    object.postulations.find_by(candidate_id: scope.id)&.status&.titleize
  end
end
