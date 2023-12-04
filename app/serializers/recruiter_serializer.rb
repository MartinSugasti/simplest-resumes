# frozen_string_literal: true

class RecruiterSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :created_at, :confirmed?, :sign_in_path, :profile_picture_url

  def created_at
    object.created_at.strftime('%d/%m/%Y %H:%M')
  end

  def confirmed?
    object.confirmed?
  end

  def sign_in_path
    recruiter_masquerade_index_path
  end

  def profile_picture_url
    rails_blob_path(object.profile_picture, only_path: true) if object.profile_picture.attached?
  end
end
