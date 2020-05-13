class PagesController < ApplicationController
  def root
  end

  def about
  end

  def secret
    # only signed in users should see this page
    unless current_user
      flash[:alert] = "You must be signed in to view this page"
      session[:user_return_to] = "/secret"
      redirect_to :root
      return
    end

    @user = User.find(current_user["id"])
  end
end
