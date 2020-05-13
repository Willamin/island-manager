class ApplicationController < ActionController::Base
  def current_user
    session[:current_user]
  end
end
