module RailsJwtAuth
  class RegistrationsController < ApplicationController
    include ParamsHelper
    include RenderHelper
    
    def create
      user = RailsJwtAuth.model.new(registration_create_params)
      n = params[:user][:name][0,4]
      number = User.where("username LIKE ?", "%#{n}%").count
        if  number !=0  
        	# user.name = "#{n} #{number}" 
        	user.username = n+number.to_s
        else
        user.username = n
       end
       user.otp_secret = ROTP::Base32.random
     

      user.save ? render_registration(user) : render_422(user.errors.details)
    end

  end
end
