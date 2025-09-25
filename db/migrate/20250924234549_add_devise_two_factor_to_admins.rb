class AddDeviseTwoFactorToAdmins < ActiveRecord::Migration[7.1]
  def change
    change_table :admins, bulk: true do |t|
      t.string :otp_secret
      t.integer :consumed_timestep
      t.boolean :otp_required_for_login, default: false, null: false
    end
  end
end
