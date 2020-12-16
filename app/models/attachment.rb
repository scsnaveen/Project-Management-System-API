class Attachment < ApplicationRecord
belongs_to :project
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }
# validates_attachment_content_type :attachment, :content_type => /image/ 
validates :attachment, :attachment_content_type => { :content_type => ['image/png', 'image/jpg']}

end
