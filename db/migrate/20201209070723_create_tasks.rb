class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t| 
      t.belongs_to :project
      t.string :name
      t.text :description 
      t.timestamps
    end
  end
end
