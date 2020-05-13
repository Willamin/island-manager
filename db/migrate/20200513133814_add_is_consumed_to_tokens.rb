class AddIsConsumedToTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :is_consumed, :boolean
  end
end
