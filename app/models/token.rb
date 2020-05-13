class Token < ApplicationRecord
  def user
    User.find(user_id)
  end

  def user=(user)
    user_id = user.id
  end
end
