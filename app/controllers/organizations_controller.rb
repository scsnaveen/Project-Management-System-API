class OrganizationsController< ApplicationController


  def index
        organization = Organization.all
       render( json: UserSerializer.action(organization).to_json)  
  end
end