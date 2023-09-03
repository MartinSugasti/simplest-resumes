class CreateInvitationRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :invitation_requests do |t|
      t.string :email, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :invitation_requests, :email, unique: true
  end
end
