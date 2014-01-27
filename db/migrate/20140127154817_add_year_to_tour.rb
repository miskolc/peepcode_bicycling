class AddYearToTour < ActiveRecord::Migration
  def change
    add_column :tours, :year, :integer
  end
end
