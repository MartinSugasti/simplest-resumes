# frozen_string_literal: true

class AddStripeCustomerIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :stripe_customer_id, :string
  end
end
