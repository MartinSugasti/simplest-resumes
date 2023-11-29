# frozen_string_literal: true

# == Schema Information
#
# Table name: skill_items
#
#  id         :bigint           not null, primary key
#  kind       :integer          default("primary"), not null
#  name       :string(40)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  resume_id  :bigint           not null
#
# Indexes
#
#  index_skill_items_on_resume_id  (resume_id)
#
# Foreign Keys
#
#  fk_rails_...  (resume_id => resumes.id)
#
class SkillItemSerializer < ActiveModel::Serializer
  attributes :id, :name
end
