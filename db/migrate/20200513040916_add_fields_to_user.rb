class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :island_name, :string
    add_column :users, :character_name, :string
  end
end
