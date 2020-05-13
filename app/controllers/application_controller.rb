class ApplicationController < ActionController::Base
  def current_user
    Token.find_by(id: cookies.signed[:current_token_id])&.user
  end
end
