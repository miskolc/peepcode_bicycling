require 'spec_helper'

describe Manager do
  
  it { should respond_to(:score_by_tour) }

  context "when he guesses the right standings," do
    let(:manager) { Manager.create! }
    let(:tour) { Tour.create!(name: "Tour of Flanders") }
    let(:cyclist1) { Cyclist.create!(name: "Mark") }
    let(:cyclist2) { Cyclist.create!(name: "John") }
    let(:cyclist3) { Cyclist.create!(name: "George") }
    let(:cyclist4) { Cyclist.create!(name: "Francisc") }
    let(:cyclist5) { Cyclist.create!(name: "Craig") }

    before do
      manager.standing_predictions.create!(tour: tour, cyclist: cyclist1, rank: 1)
      manager.standing_predictions.create!(tour: tour, cyclist: cyclist2, rank: 2)
      manager.standing_predictions.create!(tour: tour, cyclist: cyclist3, rank: 3)
      manager.standing_predictions.create!(tour: tour, cyclist: cyclist4, rank: 4)
      manager.standing_predictions.create!(tour: tour, cyclist: cyclist5, rank: 5)
      tour.standings.create!(cyclist: cyclist1, rank: 1)
      tour.standings.create!(cyclist: cyclist2, rank: 2)
      tour.standings.create!(cyclist: cyclist3, rank: 3)
      tour.standings.create!(cyclist: cyclist4, rank: 4)
      tour.standings.create!(cyclist: cyclist5, rank: 5)
    end  

    it "should compute the correct score by tour" do
      manager.score_by_tour(tour).should be 34
    end
  end
  
  context "when he doesn't guess the right position," do
    context "but he guesses that one cyclist will be in top 5," do
      let(:manager) { Manager.create! }
      let(:tour) { Tour.create! name: "Tour of Flanders" }
      let(:cyclist1) { Cyclist.create! name: "Frank" }
      let(:cyclist2) { Cyclist.create! name: "Craig"}

      before do
        manager.standing_predictions.create!(tour: tour, cyclist: cyclist1, rank: 1)
        manager.standing_predictions.create!(tour: tour, cyclist: cyclist2, rank: 2)
        tour.standings.create!(cyclist: cyclist1, rank: 5)
        tour.standings.create!(cyclist: cyclist2, rank: 6)
      end

      it "should compute the correct score by tour" do
        manager.score_by_tour(tour).should be 1
      end
    end
  end  
end