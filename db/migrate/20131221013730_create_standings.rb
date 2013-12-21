class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.integer :tour_id
      t.integer :cyclist_id
      t.integer :rank

      t.timestamps
    end
  end
end
