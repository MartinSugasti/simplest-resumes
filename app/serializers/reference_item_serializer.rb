# frozen_string_literal: true

class ReferenceItemSerializer < ActiveModel::Serializer
  attributes :id, :company, :mobile, :name, :position
end
