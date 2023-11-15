# frozen_string_literal: true

class ResumeSerializer < ActiveModel::Serializer
  attributes :name, :email, :mobile, :location, :about_me

  has_many :education_items
  has_many :work_experience_items
  has_many :primary_skill_items, serializer: SkillItemSerializer
  has_many :secondary_skill_items, serializer: SkillItemSerializer
  has_many :personal_reference_items, serializer: ReferenceItemSerializer
  has_many :job_reference_items, serializer: ReferenceItemSerializer
end
