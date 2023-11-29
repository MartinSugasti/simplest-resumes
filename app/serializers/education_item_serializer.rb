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
class EducationItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :institute, :start_year, :end_year
end
