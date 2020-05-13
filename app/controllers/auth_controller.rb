class AuthController < ApplicationController
  def accept_email
    email = params[:email]

    u = User.find_or_create_by(email: email)
    t = u.create_token

    TokenMailer.with(token: t).login_email.deliver_later

    flash[:notice] = "We sent a login email to that address."
    redirect_to :root
  end

  def add_cookie
    if t = Token.find_by_id(params[:token_id])
      session[:current_user] = t.user
      redirect_to session[:user_return_to]
    else
      flash[:alert] = "Invalid token"
      redirect_to :root
    end
  end

  def remove_cookie
    session[:current_user] = nil
    redirect_to :root
  end

  def logout
  end
end
