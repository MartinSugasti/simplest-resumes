# frozen_string_literal: true

# == Schema Information
#
# Table name: reference_items
#
#  id         :bigint           not null, primary key
#  company    :string(40)       not null
#  kind       :integer          default("personal"), not null
#  mobile     :string(20)       not null
#  name       :string(40)       not null
#  position   :string(40)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  resume_id  :bigint           not null
#
# Indexes
#
#  index_reference_items_on_resume_id  (resume_id)
#
# Foreign Keys
#
#  fk_rails_...  (resume_id => resumes.id)
#
class ReferenceItemSerializer < ActiveModel::Serializer
  attributes :id, :company, :mobile, :name, :position
end
