class MagicController < ApplicationController
  def accept_email
    flash[:notice] = "We sent a login email"
    redirect_to :root
  end

  def add_cookie
  end

  def remove_cookie
  end
end
