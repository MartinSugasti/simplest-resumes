# frozen_string_literal: true

class PriceSerializer < ActiveModel::Serializer
  attributes :id, :lookup_key, :unit_amount

  def read_attribute_for_serialization(attr)
    object[attr.to_s]
  end
end
