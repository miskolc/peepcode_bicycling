class Manager < ActiveRecord::Base
  has_many :standing_predictions


  def score_by_year(year)
    score = 0
    Tour.where(year: year).each do |tour|
      score += score_by_tour(tour)
    end
    score
  end

  def score_by_tour(tour)
    score = 0
    standing_predictions.where(tour: tour).each do |sp|
      standing = tour.standings.where(cyclist: sp.cyclist).first
      if standing
        if standing.rank == sp.rank
          score += case standing.rank
            when 1; 15
            when 2; 10
            when 3;  5
            when 4;  3
            when 5;  1
          end 
        elsif standing.rank <= 5 && sp.rank <= 5
          score += 1  
        end
      end
    end
    score
  end
end
