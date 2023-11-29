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
class WorkExperienceItemSerializer < ActiveModel::Serializer
  attributes :id, :company, :description, :end_month, :end_year, :location, :position, :start_month, :start_year
end
