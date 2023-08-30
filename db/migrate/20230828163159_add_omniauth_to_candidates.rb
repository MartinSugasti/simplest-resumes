# frozen_string_literal: true

class AddOmniauthToCandidates < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :provider, :string
    add_column :candidates, :uid, :string
  end
end
