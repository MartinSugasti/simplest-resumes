# frozen_string_literal: true

class PostulationSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes :id, :status
  belongs_to :candidate

  def status
    object.status.titleize
  end
end