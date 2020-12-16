class UserMailer < ApplicationMailer

def welcome_email(user_id)
    @user = User.find(user_id)

    mail(:to=> @user.email,:subject => "Welcome") do |format|
      format.html
    end
  end

  def mail_check(user_id)
  	@user = User.find(user_id)
  	mail(:to=> @user.email,:subject => "Welcome")
  end
end