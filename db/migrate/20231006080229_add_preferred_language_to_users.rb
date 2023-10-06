# frozen_string_literal: true

class AddPreferredLanguageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :preferred_language, :integer, default: 0, null: false
    add_column :candidates, :preferred_language, :integer, default: 0, null: false
    add_column :recruiters, :preferred_language, :integer, default: 0, null: false
  end
end
