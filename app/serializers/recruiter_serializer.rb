# frozen_string_literal: true

# == Schema Information
#
# Table name: recruiters
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  preferred_language     :integer          default("en"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_recruiters_on_confirmation_token    (confirmation_token) UNIQUE
#  index_recruiters_on_email                 (email) UNIQUE
#  index_recruiters_on_reset_password_token  (reset_password_token) UNIQUE
#
class RecruiterSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :created_at, :confirmed?, :sign_in_path, :profile_picture_url

  def created_at
    object.created_at.strftime('%d/%m/%Y %H:%M')
  end

  delegate :confirmed?, to: :object

  def sign_in_path
    recruiter_masquerade_index_path
  end

  def profile_picture_url
    rails_blob_path(object.profile_picture, only_path: true) if object.profile_picture.attached?
  end
end
