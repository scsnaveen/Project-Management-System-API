module RailsJwtAuth
  class SessionsController < ApplicationController
    include AuthenticableHelper
    include ParamsHelper
    include RenderHelper
     before_action :authenticate, only: [:destroy]

    def create
      se = Session.new(session_create_params)

      if se.generate!(request)
        render_session se.jwt, se.user
      else
        render_422 se.errors.details
      end
    end

    def destroy
      return render_404 unless RailsJwtAuth.simultaneous_sessions > 0

      # authenticate
      # render( json: UserSerializer.response_errors("YOUR_SESSION_EXPIRED").to_json, status: 401 )
      # if current_user.present?
      current_user.destroy_auth_token @jwt_payload['auth_token']
      render( json: UserSerializer.response_errors("YOUR_SESSION_EXPIRED").to_json, status: 401 )
      # else
      #   render_410
      # end
      
    end
  end
end
