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
class Recruiter < ApplicationRecord
  include Internationalizable

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :masqueradable

  has_many :job_postings, dependent: :destroy

  has_one_attached :profile_picture
  validates :profile_picture, content_type: [:png, :jpeg, :jpg], size: { less_than: 0.5.megabytes }

  def self.from_omniauth(auth)
    find_or_create_by(email: auth.info.email) do |recruiter|
      recruiter.password = Devise.friendly_token[0, 20]

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      recruiter.skip_confirmation!
    end
  end
end
