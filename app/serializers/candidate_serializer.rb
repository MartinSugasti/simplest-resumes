# frozen_string_literal: true

# == Schema Information
#
# Table name: candidates
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  plan                   :string
#  preferred_language     :integer          default("en"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  subscription_ends_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_customer_id     :string
#
# Indexes
#
#  index_candidates_on_confirmation_token    (confirmation_token) UNIQUE
#  index_candidates_on_email                 (email) UNIQUE
#  index_candidates_on_reset_password_token  (reset_password_token) UNIQUE
#
class CandidateSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :created_at, :profile_picture_url

  attribute :confirmed?, if: -> { scope.admin? }
  attribute :suscribed?, if: -> { scope.admin? }
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

  def suscribed?
    object.active_subscription?.present?
  end
end
