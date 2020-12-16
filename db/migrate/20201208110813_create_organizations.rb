class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
     t.string :organization_name

      t.timestamps
    end
        add_column :users, :organization_id, :integer
  end
end
