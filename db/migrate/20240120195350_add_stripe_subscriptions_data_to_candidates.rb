# frozen_string_literal: true

class AddStripeSubscriptionsDataToCandidates < ActiveRecord::Migration[7.0]
  def change
    change_table :candidates, bulk: true do |t|
      t.string :plan
      t.datetime :subscription_ends_at
    end
  end
end
