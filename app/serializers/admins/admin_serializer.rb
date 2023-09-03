# frozen_string_literal: true

class Admins::AdminSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :created_at, :users_invited, :invited_by, :invitation_accepted

  def role
    object.role.titleize
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y %H:%M')
  end

  def users_invited
    object.invitations_count
  end

  def invited_by
    object.invited_by&.email || '-'
  end

  def invitation_accepted
    if object.invited_by_id.present?
      object.invitation_accepted? ? 'Yes' : 'No'
    else
      '-'
    end
  end
end
