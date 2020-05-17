class AuthController < ApplicationController
  def send_magic_link
    email = params[:email]

    user = User.find_or_create_by(email: email)

    if Rails.env.development?
      if email.ends_with?("islandmanager.com")
        if user
          flash[:dingus] = "You're in development, so you are now logged in as #{email}"
          cookies.encrypted[:user_id] = {
            :value => user.id,
            :expires => 30.days
          }
          redirect_to :root
          return
        end
      end
    end

    t = user.create_token

    TokenMailer.with(token: t).login_email.deliver_now

    flash[:dingus] = "We sent a login email to that address."
    redirect_to :root
  end

  def authenticate
    unless emailed_token = Token.find_by(id: params[:token_id], created_at: 1.hour.ago..Time.current)
      flash[:widget] = "Invalid token"
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
    flash[:dingus] = "Welcome, #{user.name || user.email}"
    redirect_to(return_to || :root)
  end

  def logout
    if current_user
      cookies.delete(:user_id)
      flash[:dingus] = "Successfully logged out"
    else
      flash[:gizmo] = "Already logged out"
    end
    redirect_to :root
  end

  def logout_page
  end
end
