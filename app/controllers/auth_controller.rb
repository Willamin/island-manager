class AuthController < ApplicationController
  def accept_email
    email = params[:email]

    u = User.find_or_create_by(email: email)
    t = u.create_token

    TokenMailer.with(token: t).login_email.deliver_now

    flash[:notice] = "We sent a login email to that address."
    redirect_to :root
  end

  def add_cookie
    if t = Token.find_by_id(params[:token_id])
      session[:current_token_id] = t.id
      return_to = session[:user_return_to]
      session[:user_return_to] = nil
      redirect_to(return_to || :root)
    else
      flash[:alert] = "Invalid token"
      redirect_to :root
    end
  end

  def remove_cookie
    session[:current_token_id] = nil
    redirect_to :root
  end

  def logout
  end
end
