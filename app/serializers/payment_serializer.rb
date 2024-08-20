# frozen_string_literal: true

class PaymentSerializer < ActiveModel::Serializer
  attributes :stripe_id, :amount, :candidate_email, :status, :created_at

  def stripe_id
    object['id']
  end

  def amount
    object['amount_received'] / 100
  end

  def candidate_email
    Candidate.find_by(stripe_customer_id: object['customer'])&.email || 'Not Found'
  end

  def status
    object['status'].capitalize
  end

  def created_at
    Time.zone.at(object['created']).strftime('%d/%m/%Y %H:%M')
  end
end
