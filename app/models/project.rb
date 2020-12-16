class Project < ApplicationRecord
	belongs_to :user
	 has_many :tasks
	 # enum types: [ :Training, :Project ]
   	has_many :attachments
end
