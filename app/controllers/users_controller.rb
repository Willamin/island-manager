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
    ensure_authentication
    redirect_to "/user/#{current_user["id"]}"
  end

  def update
    ensure_authentication

    @user = User.find(current_user["id"])
    @user.name = params[:name]
    @user.island_name = params[:island_name]
    @user.character_name = params[:character_name]
    @user.save!

    flash[:success] = "You've successfully updated your profile."
    redirect_to "/user/me"
  end
end
