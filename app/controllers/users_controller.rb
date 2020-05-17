class UsersController < ApplicationController
  def profile
    @user = User.find_by(id: params[:id])
    if current_user && @user == current_user
      if (@turnips = @user.turnip_weeks.first).nil?
        @turnips = TurnipWeek.new
        @user.turnip_weeks << @turnips
      end
      render "me"
    else
      @turnips = @user.turnip_weeks.first
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

    flash[:dingus] = "You've successfully updated your profile."
    redirect_to "/user/me"
  end

  # turnips

  def update_current_turnips
    ensure_authentication

    @turnips = current_user.turnip_weeks.first

    %w(sunday monday tuesday wednesday thursday friday saturday).each_with_index do |day, index|
      key_am = (day + "_am")
      @turnips.send(key_am +"=", params[key_am.to_sym])

      unless index == 0
        key_pm = (day + "_pm")
        @turnips.send(key_pm +"=", params[key_pm.to_sym])
      end
    end

    @turnips.save

    flash[:dingus] = "You've successfully updated your turnip prices for this week."
    redirect_to "/user/me"
  end
end
