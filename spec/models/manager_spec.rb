require 'spec_helper'

describe Manager do
  
  it { should respond_to(:score_by_tour) }
  it { should respond_to(:score_by_year) }

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

  context "when he guesses accross multiple tours in the same year," do 
    let(:manager) { Manager.create! }
    let(:year)    { 2013 }
    let(:tour1)   { Tour.create! name: "Tour of Flanders", year: year }
    let(:tour2)   { Tour.create! name: "Tour of France" , year: year }
    let(:cyclist) { Cyclist.create! name: "Frank" }

    before do
      manager.standing_predictions.create!(tour: tour1, cyclist: cyclist, rank: 1)
      manager.standing_predictions.create!(tour: tour2, cyclist: cyclist, rank: 1)
      tour1.standings.create!(cyclist: cyclist, rank: 1)
      tour2.standings.create!(cyclist: cyclist, rank: 1)
    end

    it "should compute the correct scores by tour" do
      manager.score_by_tour(tour1).should be 15
      manager.score_by_tour(tour2).should be 15
    end

    it "should compute the correct score by year" do
      manager.score_by_year(year).should be 30
    end   
  end

  context "when he guesses accross multiple tours in different years," do 
    let(:manager)   { Manager.create! }
    let(:tour_2013) { Tour.create! name: "Tour of France", year: 2013 }
    let(:tour_2014) { Tour.create! name: "Tour of France", year: 2014 }
    let(:cyclist)   { Cyclist.create! name: "Frank" }

    before do
      manager.standing_predictions.create!(tour: tour_2013, cyclist: cyclist, rank: 1)
      manager.standing_predictions.create!(tour: tour_2014, cyclist: cyclist, rank: 1)
      tour_2013.standings.create!(cyclist: cyclist, rank: 1)
      tour_2014.standings.create!(cyclist: cyclist, rank: 1)
    end

    it "should compute the correct scores by tour" do
      manager.score_by_tour(tour_2013).should be 15
      manager.score_by_tour(tour_2014).should be 15
    end   

    it "should compute the correct scores by years" do
      manager.score_by_year(2013).should be 15
      manager.score_by_year(2014).should be 15
    end
  end 
end