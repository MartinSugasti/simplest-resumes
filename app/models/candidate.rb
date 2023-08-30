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
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_candidates_on_confirmation_token    (confirmation_token) UNIQUE
#  index_candidates_on_email                 (email) UNIQUE
#  index_candidates_on_reset_password_token  (reset_password_token) UNIQUE
#
class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :trackable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :masqueradable

  devise :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |candidate|
      candidate.email = auth.info.email
      candidate.password = Devise.friendly_token[0, 20]

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      candidate.skip_confirmation!
    end
  end
end
