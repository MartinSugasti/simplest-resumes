class CreateJobPostings < ActiveRecord::Migration[7.0]
  def change
    create_table :job_postings do |t|
      t.string :title, limit: 40, null: false
      t.string :company, limit: 40, null: false
      t.string :skills, limit: 80, null: false
      t.text :description, null: false
      t.boolean :published, null: false, default: false
      t.belongs_to :recruiter, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
