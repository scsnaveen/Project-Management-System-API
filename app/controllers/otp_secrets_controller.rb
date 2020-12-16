class OtpSecretsController < ApplicationController
  before_action :authenticate!
  def validate_otp
    otp_secret = params[:otp]
    totp = ROTP::TOTP.new(current_user.otp_secret)
    last_otp_at = totp.verify(params[:otp], drift_behind: 160)
    enable_2fa = params[:enable_2fa]
    if last_otp_at #== current_user.otparray
      if enable_2fa == true
        current_user.otp_enabled = "t"
        current_user.otparray = 10.times.map{rand(7 ** 7)}
        # current_user.alternate_otp = rand(7 ** 7)
        current_user.save
        render( json: UserSerializer.error("Enabled").to_json) 
        return
      else 
        current_user.otp_enabled = "f"
        current_user.alternate_otp = nil
        current_user.save
        render( json: UserSerializer.error("Disabled").to_json)
        return 
      end
    else
      if enable_2fa == false
        if current_user.otparray.include?(otp_secret)
        puts  params[:otp]
          current_user.otparray.delete(otp_secret)
          current_user.otp_enabled = "f"
          current_user.save
          # current_user.otparray.delete{|c| c.include?(otp_secret) }

          render( json: UserSerializer.error("Disabled").to_json) 
          return
        end 
      end# disable
    end#if last_otp_at
    render( json: UserSerializer.error("Invalid").to_json)
  end#def validate_otp

  def sign_in_otp
    if current_user.otp_enabled == "t"
      otp_secret = params[:otp]
      totp = ROTP::TOTP.new(current_user.otp_secret)
      last_otp_at = totp.verify(params[:otp], drift_behind: 160)
      if otp_secret == current_user.alternate_otp || last_otp_at
        render( json: UserSerializer.error("Verified").to_json)
      else
        render( json: UserSerializer.error("Invalid Token").to_json)  
      end
    else
      render( json: UserSerializer.error("No Verification").to_json)  
    end#if current_user.otp_enabled == "t"
    
  end #def
    def get_otp
       render( json: UserSerializer.error(current_user.otp_secret).to_json)
    end  
end
