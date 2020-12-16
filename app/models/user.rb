class User < ApplicationRecord
  include RailsJwtAuth::Authenticatable
  include RailsJwtAuth::Confirmable
  include RailsJwtAuth::Recoverable
  include RailsJwtAuth::Trackable
  include RailsJwtAuth::Invitable
  include RailsJwtAuth::Lockable

  has_many :invitations, class_name: self.to_s, as: :invited_by
  belongs_to :invited_by, polymorphic: false, optional: true
  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: URI::MailTo::EMAIL_REGEXP
  validates :username, uniqueness: true
   # invitable invitation_by: :email
     belongs_to :organization
    has_many :projects
   has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :picture, presence: true
   do_not_validate_attachment_file_type :picture
end