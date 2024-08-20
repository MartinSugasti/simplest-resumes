# frozen_string_literal: true

class CreatePostulations < ActiveRecord::Migration[7.0]
  def change
    create_table :postulations do |t|
      t.integer :status, null: false, default: 0
      t.belongs_to :candidate, null: false, foreign_key: true, index: true
      t.belongs_to :job_posting, null: false, foreign_key: true, index: true
      t.index %i[candidate_id job_posting_id], unique: true

      t.timestamps
    end
  end
end
