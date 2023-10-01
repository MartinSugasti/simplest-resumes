# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("super_admin"), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_admins_on_confirmation_token    (confirmation_token) UNIQUE
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_invitation_token      (invitation_token) UNIQUE
#  index_admins_on_invited_by            (invited_by_type,invited_by_id)
#  index_admins_on_invited_by_id         (invited_by_id)
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :invitations, class_name: self.to_s, as: :invited_by

  enum role: {
    super_admin: 0,
    collaborator: 1
  }

  def send_devise_notification(notification, *args)
    I18n.with_locale(I18n.locale) do
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end
end
