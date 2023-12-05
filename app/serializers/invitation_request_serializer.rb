# frozen_string_literal: true

# == Schema Information
#
# Table name: invitation_requests
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invitation_requests_on_email  (email) UNIQUE
#
class InvitationRequestSerializer < ActiveModel::Serializer
  attributes :id, :email, :status, :invited_as, :created_at

  def status
    admin = Admin.find_by(email: object.email)

    # Might have added a new status to the invitation request, but what is accepted is the
    # invitation, not the invitation request. Besides that, it would add extra unnecessary
    # complexity to validations for InvitationRequest model
    if admin.present? && admin.invitation_accepted?
      I18n.t('admins.invitation_request_serializer.accepted')
    else
      ApplicationHelper.translate_enum_value('invitation_request', 'statuses', object.status)
    end
  end

  def invited_as
    if object.approved?
      admin_role = Admin.find_by(email: object.email)&.role
      return ApplicationHelper.translate_enum_value('admin', 'roles', admin_role) if admin_role.present?

      I18n.t('admins.invitation_request_serializer.admin_not_found')
    else
      '-'
    end
  end

  def created_at
    object.created_at.strftime('%d/%m/%Y %H:%M')
  end
end
