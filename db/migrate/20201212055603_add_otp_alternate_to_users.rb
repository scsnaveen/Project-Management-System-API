class AddOtpAlternateToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :alternate_otp, :string
  end
end
