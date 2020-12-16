module RailsJwtAuth
  # include RenderHelper
  NotAuthorized = Class.new(StandardError)

  module AuthenticableHelper
    def current_user
      @current_user
    end

    def jwt_payload
      @jwt_payload
    end

    def signed_in?
      !current_user.nil?
    end

    def get_jwt_from_request
      request.env['HTTP_AUTHORIZATION']&.split&.last
    end

    # def authenticate!
    #   begin
    #     puts "1111"
    #     @jwt_payload = RailsJwtAuth::JwtManager.decode(get_jwt_from_request).first
    #     if !JWT::ExpiredSignature || !JWT::VerificationError || !JWT::DecodeError
    #       render( json: UserSerializer.error("Invalid Token").to_json, status: 401)
    #       return
    #     end#if !JWT::ExpiredSignature || !JWT::VerificationError || !JWT::DecodeError
    #   end

    #   if !@current_user = RailsJwtAuth.model.from_token_payload(@jwt_payload)
    #     puts "22222"
    #     render( json: UserSerializer.error("Invalid Token").to_json, status: 401)
    #     return
    #   else
    #     track_request
    #   end
    # end

    def authenticate! 
      begin  
        payload = RailsJwtAuth::JwtManager.decode(get_jwt_from_request).first

        if !JWT::ExpiredSignature || !JWT::VerificationError || !JWT::DecodeError
          render( json: UserSerializer.response_errors("YOUR_SESSION_EXPIRED").to_json, status: 401 )
        end
      end
      if !@current_user = RailsJwtAuth.model.from_token_payload(payload)
        render( json: UserSerializer.response_errors("YOUR_SESSION_EXPIRED").to_json, status: 401 )

      elsif @current_user.respond_to? :update_tracked_fields!
        @current_user.update_tracked_fields!(request)
      end
    end


    def authenticate
      begin
        @jwt_payload = RailsJwtAuth::JwtManager.decode(get_jwt_from_request).first
        @current_user = RailsJwtAuth.model.from_token_payload(@jwt_payload)
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        @current_user = nil
      end

      if !@current_user.present?
        puts "hello"
        render( json: UserSerializer.response_errors("YOUR_SESSION_EXPIRED").to_json, status: 401 )
        return
      else
        track_request
      end
    end

    def unauthorize!
      raise NotAuthorized
    end

    def track_request
      if @current_user&.respond_to? :update_tracked_request_info
        @current_user.update_tracked_request_info(request)
      end
    end
  end
end
