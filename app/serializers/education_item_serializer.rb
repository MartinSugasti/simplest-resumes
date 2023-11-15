# frozen_string_literal: true

class EducationItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :institute, :start_year, :end_year
end
