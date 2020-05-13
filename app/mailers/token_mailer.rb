class TokenMailer < ApplicationMailer
  def login_email
    @token = params[:token]
    @user = @token.user
    mail(to: @user.email, subject: "Login to Island Manager")
  end
end
