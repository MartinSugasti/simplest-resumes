# frozen_string_literal: true

class AddStripeSubscriptionsDataToCandidates < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :plan, :string
    add_column :candidates, :subscription_ends_at, :datetime
  end
end
