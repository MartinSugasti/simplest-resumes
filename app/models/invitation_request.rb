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
class InvitationRequest < ApplicationRecord
  validates :email, :status, presence: true
  validates :email, uniqueness: {
    message: "already has an invitation request. If you haven't receive an invitation, please contact "\
             "<a href='mailto:#{Rails.configuration.contact_email}' class='text-muted'>"\
             "#{Rails.configuration.contact_email}</a> for more information"
  }
  validate :check_if_admin_already_exists, on: :create
  validate :email_cannot_change, on: :update
  validate :invitation_request_already_approved, on: :update, if: -> { !approved? }

  enum status: {
    pending: 0,
    approved: 1,
    dismissed: 2,
    banned: 3
  }

  private

  def check_if_admin_already_exists
    return unless Admin.find_by(email: email).present?

    errors.add(:base, 'An Admin already exists for the email')
  end

  def email_cannot_change
    return unless will_save_change_to_email?

    errors.add(:base, 'Email cannot be changed')
  end

  def invitation_request_already_approved
    return unless status_was == 'approved'

    errors.add(:base, 'Status cannot be changed once the invitation request was approved')
  end

  def invitation_request_already_approved
    return unless Admin.find_by(email: email).present?

    errors.add(:base, 'Invitation request cannot be updated because an Admin already exists')
  end
end
