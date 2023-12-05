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
#  preferred_language     :integer          default("en"), not null
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
class AdminSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :created_at, :admins_invited, :invited_by, :invitation_accepted

  def role
    ApplicationHelper.translate_enum_value('admin', 'roles', object.role)
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y %H:%M')
  end

  def admins_invited
    object.invitations.count
  end

  def invited_by
    object.invited_by&.email || '-'
  end

  def invitation_accepted
    return '-' if object.invited_by.nil?

    object.invitation_accepted? ? I18n.t('general.yes') : I18n.t('general.no')
  end
end
