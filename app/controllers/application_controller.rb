class AuthenticationFailure < StandardError; end

class ApplicationController < ActionController::Base
  rescue_from AuthenticationFailure, :with => :handle_auth_failure

  def current_user
    @current_user ||= User.find_by(id: cookies.encrypted[:user_id])
  end

  def ensure_authentication
    unless current_user
      raise AuthenticationFailure
    end
  end

  def handle_auth_failure
    flash[:widget] = "You must be signed in to view this page"
    session[:user_return_to] = request.path
    redirect_to :root
  end
end
