class AuthenticationFailure < StandardError; end

class ApplicationController < ActionController::Base
  rescue_from AuthenticationFailure, :with => :handle_auth_failure

  def current_user
    unless token = Token.where(id: cookies.signed[:current_token_id], created_at: 30.days.ago..Time.current).first
      return nil
    end

    token.user
  end

  def ensure_authentication
    unless current_user
      raise AuthenticationFailure
    end
  end

  def handle_auth_failure
    flash[:alert] = "You must be signed in to view this page"
    session[:user_return_to] = request.path
    redirect_to :root
  end
end
