require_relative "20200513133814_add_is_consumed_to_tokens"

class RevertAddIsConsumedToTokens < ActiveRecord::Migration[6.0]
  def change
    revert AddIsConsumedToTokens
  end
end
