class Standing < ActiveRecord::Base
  belongs_to :cyclist
  belongs_to :tour
  [:cyclist_id, :tour_id, :rank].each do |attribute|
    validates attribute, presence: true
  end
  #validates_uniqueness_of :rank, scope: [:cyclist_id, :tour_id]
  validates_uniqueness_of :rank, scope: [:tour_id]
  validates_uniqueness_of :cyclist_id, scope: [:tour_id]
end
# rank cyclist tour | Chinese ME
# 1 1 1  OK OK
## 2 2 1  OK OK
## 2 1 2  OK OK
## 1 2 2  OK OK 
# 1 1 2  OK OK  
# 1 1 1  NO NO 
# 1 2 1  OK NO
# 2 1 1  NO NO