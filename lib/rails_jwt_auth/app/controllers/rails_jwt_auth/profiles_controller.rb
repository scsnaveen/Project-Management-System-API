module RailsJwtAuth
  class ProfilesController < ApplicationController
    include ParamsHelper
    include RenderHelper

    PASSWORD_PARAMS = %i[current_password password password_confirmation].freeze

    before_action :authenticate!

    def show
      render_profile current_user
    end

    def update
      puts"---------------------------------------"
      # puts current_user
      # puts current_user.authenticate(params[:password])
      if current_user.authenticate(params[:password])
       puts"---------------------------------------"
      puts current_user.authenticate(params[:password])
        if current_user.update(profile_update_params)
          current_user.save
          render_204
        else
          render_422(current_user.errors.details)
        end
      elsif params[:password].present?
       render( json: UserSerializer.error("wrong password").to_json)
      else
       render( json: UserSerializer.error("password must exists").to_json)
     end
    end

    def password
      if current_user.update_password(update_password_params)
        render_204
      else
        render_422(current_user.errors.details)
      end
    end

    def email
      return update unless current_user.is_a?(RailsJwtAuth::Confirmable)

      if current_user.update_email(profile_update_email_params)
        render_204
      else
        render_422(current_user.errors.details)
      end
    end
    def picture
       if current_user.authenticate(params[:password])
        puts current_user.authenticate(params[:password])
        image = Paperclip.io_adapters.for(params[:picture])
        image.original_filename = "file.jpg"
        current_user.picture = image
        current_user.save
     else
        render( json: UserSerializer.error("password required or wrong password").to_json)
     end  
    end

    protected

    def changing_password?
      profile_update_params.values_at(*PASSWORD_PARAMS).any?(&:present?)
    end

    def update_password_params
      profile_update_password_params.merge(current_auth_token: jwt_payload['auth_token'])
    end
  end
end
