class CreateCyclists < ActiveRecord::Migration
  def change
    create_table :cyclists do |t|
      t.string :name

      t.timestamps
    end
  end
end
