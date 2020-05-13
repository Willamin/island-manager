class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens, id: :uuid do |t|
      t.uuid :user_id

      t.timestamps
    end

    add_index :tokens, :user_id
  end
end
