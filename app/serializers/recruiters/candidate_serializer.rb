# frozen_string_literal: true

class Recruiters::CandidateSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :profile_picture_url, :primary_skills, :about_me, :resume_id

  def profile_picture_url
    rails_blob_path(object.profile_picture, only_path: true) if object.profile_picture.attached?
  end

  def primary_skills
    object.primary_skill_items.pluck(:name).join(', ')
  end

  def resume_id
    object.resume&.id
  end
end
