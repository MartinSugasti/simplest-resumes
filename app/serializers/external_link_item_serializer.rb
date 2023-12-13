# frozen_string_literal: true

# == Schema Information
#
# Table name: external_link_items
#
#  id         :bigint           not null, primary key
#  name       :string(40)       not null
#  url        :string(80)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  resume_id  :bigint           not null
#
# Indexes
#
#  index_external_link_items_on_resume_id  (resume_id)
#
# Foreign Keys
#
#  fk_rails_...  (resume_id => resumes.id)
#
class ExternalLinkItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :url
end
