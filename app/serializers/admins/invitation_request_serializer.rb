# frozen_string_literal: true

class Admins::InvitationRequestSerializer < ActiveModel::Serializer
  attributes :id, :email, :status, :invited_as, :created_at

  def status
    admin = Admin.find_by(email: object.email)

    # Might have added a new status to the invitation request, but what is accepted is the
    # invitation, not the invitation request. Besides that, it would add extra unnecessary
    # complexity to validations for InvitationRequest model
    if admin.present? && admin.invitation_accepted?
      'Accepted'
    else
      object.status.titleize
    end
  end

  def invited_as
    if object.approved?
      Admin.find_by(email: object.email)&.role&.titleize || 'Admin Not Found'
    else
      '-'
    end
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y %H:%M')
  end
end
