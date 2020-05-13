class PagesController < ApplicationController
  def root
  end

  def about
  end

  def secret
    unless current_user
      flash[:alert] = "You must be signed in to view this page"
      session[:user_return_to] = "/secret"
      redirect_to :root
    end
    # only signed in users should see this page
  end
end
