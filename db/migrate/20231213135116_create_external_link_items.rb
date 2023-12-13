# frozen_string_literal: true

class CreateExternalLinkItems < ActiveRecord::Migration[7.0]
  def change
    create_table :external_link_items do |t|
      t.string :name, limit: 40, null: false
      t.string :url, limit: 80, null: false
      t.belongs_to :resume, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
