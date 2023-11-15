# frozen_string_literal: true

class WorkExperienceItemSerializer < ActiveModel::Serializer
  attributes :id, :company, :description, :end_month, :end_year, :location, :position, :start_month, :start_year
end
