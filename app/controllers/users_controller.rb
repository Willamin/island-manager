class UsersController < ApplicationController
  def profile
    @user = User.find_by(id: params[:id])
    if current_user && @user == current_user
      render "me"
    else
      render "profile"
    end
  end

  def me
    # only signed in users should see this page
    unless current_user
      flash[:alert] = "You must be signed in to view this page"
      session[:user_return_to] = "/user/me"
      redirect_to :root
      return
    end

    redirect_to "/user/#{current_user["id"]}"
  end

  def update
    # only signed in users should see this page
    unless current_user
      flash[:alert] = "You must be signed in to make this update"
      session[:user_return_to] = "/user/me"
      redirect_to :root
      return
    end

    @user = User.find(current_user["id"])
    @user.name = params[:name]
    @user.island_name = params[:island_name]
    @user.character_name = params[:character_name]
    @user.save!

    flash[:notice] = "You've successfully updated your profile."
    redirect_to "/user/me"
  end
end
