# frozen_string_literal: true

# == Schema Information
#
# Table name: resumes
#
#  id           :bigint           not null, primary key
#  about_me     :text
#  email        :string(40)
#  location     :string(40)
#  mobile       :string(20)
#  name         :string(40)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  candidate_id :bigint           not null
#
# Indexes
#
#  index_resumes_on_candidate_id  (candidate_id)
#
# Foreign Keys
#
#  fk_rails_...  (candidate_id => candidates.id)
#
class ResumeSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :mobile, :location, :about_me

  has_many :education_items
  has_many :work_experience_items
  has_many :primary_skill_items, serializer: SkillItemSerializer
  has_many :secondary_skill_items, serializer: SkillItemSerializer
  has_many :personal_reference_items, serializer: ReferenceItemSerializer
  has_many :job_reference_items, serializer: ReferenceItemSerializer
  has_many :external_link_items
end
