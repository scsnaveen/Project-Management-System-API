class AddAlternateOtpArrayToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users,:otparray,:string, array: true, default: []
  end
end
