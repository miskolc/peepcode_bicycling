class StandingPrediction < ActiveRecord::Base
  belongs_to :cyclist
  belongs_to :manager
  belongs_to :tour

  [:cyclist_id, :tour_id, :manager_id, :rank].each do |attribute|
    validates attribute, presence: true
  end
  
  #validates_uniqueness_of :rank, scope: [:cyclist_id, :tour_id, :manager_id]
  validates_uniqueness_of :rank, scope: [:tour_id, :manager_id]
  validates_uniqueness_of :cyclist_id, scope: [:tour_id, :manager_id]
end
