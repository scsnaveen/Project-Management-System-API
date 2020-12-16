class AddAttachmentAttachmentToProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.belongs_to :project 
      t.attachment :attachment
      t.timestamps
    end
  end
end
