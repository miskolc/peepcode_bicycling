require 'spec_helper'

describe StandingPrediction do
  it { should respond_to :manager }
  it { should respond_to :tour }
  it { should respond_to :cyclist }

  context "Testing uniqueness validation\n" do
    let(:c1) { Cyclist.create!(name: "Patrick") }
    let(:c2) { Cyclist.create!(name: "Jackson") }
    let(:t1) { Tour.create!(name: "Tour de France") }
    let(:t2) { Tour.create!(name: "Tour of Flanders") }
    let(:m1) { Manager.create! }
    let(:m2) { Manager.create! }
    
    before do
      m1.standing_predictions.create!(rank: 1, tour: t1, cyclist: c1)
    end
    # Make sure one Rank can appear only once for each tour of each manager
    subject { m1 }
    it "should not be able to select a rank more than once in a tour" do
      expect { m1.standing_predictions.create!(rank: 1, tour: t1, cyclist: c1) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { m1.standing_predictions.create!(rank: 1, tour: t1, cyclist: c2) }.to raise_error(ActiveRecord::RecordInvalid)
    end  

    # Make sure one Cyclist can appear only once for each tour of each manager
    it "Manager should not be able to select a cyclist more than once in a tour" do
      expect { m1.standing_predictions.create!(rank: 1, tour: t1, cyclist: c1) }.to raise_error(ActiveRecord::RecordInvalid)
      expect { m1.standing_predictions.create!(rank: 2, tour: t1, cyclist: c1) }.to raise_error(ActiveRecord::RecordInvalid)
    end

  end
end  