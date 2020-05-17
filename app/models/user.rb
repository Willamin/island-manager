class User < ApplicationRecord
  self.implicit_order_column = "created_at"

  has_many :tokens
  has_many :turnip_weeks

  def create_token
    Token.create(user_id: id)
  end
end
