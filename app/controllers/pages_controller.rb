class PagesController < ApplicationController
  def root
  end

  def about
  end

  def secret
    ensure_authentication
    @user = User.find(current_user["id"])
  end
end
