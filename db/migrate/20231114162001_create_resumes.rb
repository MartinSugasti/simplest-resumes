class CreateResumes < ActiveRecord::Migration[7.0]
  def change
    create_table :resumes do |t|
      t.string :name, limit: 40
      t.string :email, limit: 40
      t.string :mobile, limit: 20
      t.string :location, limit: 40
      t.text :about_me
      t.belongs_to :candidate, null: false, foreign_key: true, index: true

      t.timestamps
    end

    create_table :education_items do |t|
      t.string :name, limit: 40, null: false
      t.string :institute, limit: 40, null: false
      t.integer :start_year, null: false
      t.integer :end_year
      t.belongs_to :resume, null: false, foreign_key: true, index: true

      t.timestamps
    end

    create_table :work_experience_items do |t|
      t.string :position, limit: 40, null: false
      t.string :company, limit: 40, null: false
      t.integer :start_month, null: false
      t.integer :start_year, null: false
      t.integer :end_month
      t.integer :end_year
      t.string :location, limit: 40, null: false
      t.text :description, null: false
      t.belongs_to :resume, null: false, foreign_key: true, index: true

      t.timestamps
    end

    create_table :skill_items do |t|
      t.string :name, limit: 40, null: false
      t.integer :kind, null: false, default: 0
      t.belongs_to :resume, null: false, foreign_key: true, index: true

      t.timestamps
    end

    create_table :reference_items do |t|
      t.integer :kind, null: false, default: 0
      t.string :name, limit: 40, null: false
      t.string :mobile, limit: 20, null: false
      t.string :company, limit: 40, null: false
      t.string :position, limit: 40, null: false
      t.belongs_to :resume, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
