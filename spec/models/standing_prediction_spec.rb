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

    
  end
end  