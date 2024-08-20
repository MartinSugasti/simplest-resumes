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
    message: lambda do |_record, data|
      I18n.t(
        'activerecord.errors.models.invitation_request.attributes.email.custom_taken',
        email: Rails.configuration.contact_email,
        value: data[:value]
      )
    end
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
    return if Admin.find_by(email: email).blank?

    errors.add(:email, :admin_already_exists)
  end

  def email_cannot_change
    return unless will_save_change_to_email?

    errors.add(:email, :cannot_be_changed)
  end

  def invitation_request_already_approved
    return unless status_was == 'approved'

    errors.add(:status, :invitation_request_already_approved)
  end
end
