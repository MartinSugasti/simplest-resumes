# frozen_string_literal: true

class SubscriptionSerializer < ActiveModel::Serializer
  attributes :active, :ends_at

  def active
    object.active_subscription?
  end

  def ends_at
    object.subscription_ends_at&.strftime('%b, %e, %Y')
  end
end
