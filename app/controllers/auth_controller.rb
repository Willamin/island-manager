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
    unless emailed_token = Token.find_by_id(params[:token_id])
      raise BadAuthTokenError
    end

    if emailed_token.is_consumed?
      raise BadAuthTokenError
    end

    if emailed_token.created_at.before? 1.hour.ago
      raise BadAuthTokenError
    end

    emailed_token.is_consumed = true
    user = emailed_token.user

    new_token = Token.create(user_id: user.id)

    cookies.signed[:current_token_id] = {
     :value => new_token.id,
     :expires => 30.days
    }

    return_to = session[:user_return_to]
    session[:user_return_to] = nil
    flash[:notice] = "Welcome, #{user.name || user.email}"
    redirect_to(return_to || :root)
  rescue BadAuthTokenError
    flash[:alert] = "Invalid token"
    redirect_to :root
  end

  def remove_cookie
    cookies.delete(:current_token_id)
    redirect_to :root
  end

  def logout
  end
end

class BadAuthTokenError < StandardError; end
