class CreateStandingPredictions < ActiveRecord::Migration
  def change
    create_table :standing_predictions do |t|
      t.integer :manager_id
      t.integer :tour_id
      t.integer :cyclist_id
      t.integer :rank

      t.timestamps
    end
  end
end
