class ApplicationController < ActionController::Base
  def current_user
    Token.find_by(id: session[:current_token_id])&.user
  end
end
