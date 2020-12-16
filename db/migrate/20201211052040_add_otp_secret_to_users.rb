class AddOtpSecretToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :otp_secret, :string
    add_column :users, :last_otp_at, :integer
    add_column :users, :otp_enabled, :string, :default => "f"

  end
end
