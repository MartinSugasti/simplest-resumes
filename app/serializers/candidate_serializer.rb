# frozen_string_literal: true

class CandidateSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :created_at, :profile_picture_url

  attribute :confirmed?, if: -> { scope.admin? }
  attribute :created_at, if: -> { scope.admin? }
  attribute :sign_in_path, if: -> { scope.admin? }

  attribute :primary_skills, if: -> { scope.recruiter? }
  attribute :about_me, if: -> { scope.recruiter? }
  attribute :resume_id, if: -> { scope.recruiter? }

  def created_at
    object.created_at.strftime('%d/%m/%Y %H:%M')
  end

  def sign_in_path
    candidate_masquerade_index_path
  end

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
