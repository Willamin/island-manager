class ApplicationController < ActionController::Base
  def current_user
    token = Token.find_by(id: cookies.signed[:current_token_id])
    if token == nil
      return nil
    end

    if token.created_at.before? 30.days.ago
      return nil
    end

    token.user
  end
end
