class CreateTurnipWeeks < ActiveRecord::Migration[6.0]
  def change
    create_table :turnip_weeks, id: :uuid do |t|
      t.integer :sunday_am
      t.integer :monday_am
      t.integer :monday_pm
      t.integer :tuesday_am
      t.integer :tuesday_pm
      t.integer :wednesday_am
      t.integer :wednesday_pm
      t.integer :thursday_am
      t.integer :thursday_pm
      t.integer :friday_am
      t.integer :friday_pm
      t.integer :saturday_am
      t.integer :saturday_pm

      t.uuid :user_id

      t.timestamps
    end

    add_index :turnip_weeks, :user_id
  end
end
