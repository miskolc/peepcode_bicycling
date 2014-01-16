class Tour < ActiveRecord::Base
  has_many :standings
  has_many :standing_predictions

  validates :name, presence: true
end
