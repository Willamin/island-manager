class AuthController < ApplicationController
  def send_magic_link
    email = params[:email]

    u = User.find_or_create_by(email: email)
    t = u.create_token

    TokenMailer.with(token: t).login_email.deliver_now

    flash[:notice] = "We sent a login email to that address."
    redirect_to :root
  end

  def authenticate
    unless emailed_token = Token.where(id: params[:token_id], created_at: 1.hour.ago..Time.current).first
      flash[:alert] = "Invalid token"
      redirect_to :root
      return
    end

    user = emailed_token.destroy.user

    cookies.encrypted[:user_id] = {
     :value => user.id,
     :expires => 30.days
    }

    return_to = session[:user_return_to]
    session[:user_return_to] = nil
    flash[:notice] = "Welcome, #{user.name || user.email}"
    redirect_to(return_to || :root)
  end

  def logout
    if current_user
      cookies.delete(:user_id)
      flash[:notice] = "Successfully logged out"
    else
      flash[:notice] = "Already logged out"
    end
    redirect_to :root
  end

  def logout_page
  end
end
