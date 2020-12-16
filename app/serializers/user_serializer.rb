class UserSerializer < ActiveModel::Serializer
  # attributes :id

  def self.error(message)
  	message
  end

  def self.response_errors(error)
  	puts "error"
    error
  end
  def self.action(organizations)
  	success = {
  		"value"=>"organizations",
  		"organizations"=>organizations
  	}
  end
 
end
