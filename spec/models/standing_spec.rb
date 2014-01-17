require "spec_helper"

describe Standing do 
  it { should respond_to :cyclist }
  it { should respond_to :tour }

  context "where Standings" do
    # For each tour every rank should be unique
    # For each tour there every rank id must be unique
    
    let(:c1) { Cyclist.create!(name: "Patrick") }
    let(:c2) { Cyclist.create!(name: "Jackson") }
    let(:t1) { Tour.create!(name: "Tour de France") }
    let(:t2) { Tour.create!(name: "Tour of Flanders") }

    before do
      #Creating the first Standing
      c1.standings.create!(rank: 1, tour: t1)
    end
    

    it "allow one CYCLIST to have the same RANK accross multiple TOURS" do
      expect { c1.standings.create!(rank: 1, tour: t2) }.to_not raise_error  
    end
    
    it "not allow one CYCLIST to have the same RANK in the same TOUR multiple times" do
      expect { c1.standings.create!(rank: 1, tour: t1) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "not allow two different CYCLISTS to have the same RANK in the same TOUR" do
      expect { c2.standings.create!(rank: 1, tour: t1) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "not allow one CYCLIST to have more than one RANK in the same TOUR" do
      expect { c1.standings.create!(rank: 2, tour: t1) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "allow different CYCLISTS to have different RANKS in the same TOUR" do 
      expect { c2.standings.create!(rank: 2, tour: t1) }.to_not raise_error
    end

    it "allow one CYCLIST to have different RANKS in different TOURS" do
      expect { c1.standings.create!(rank: 2, tour: t2) }.to_not raise_error
    end  

    it "allow different CYCLISTS to have the same RANK in different TOURS" do 
      expect { c2.standings.create!(rank: 1, tour: t2) }.to_not raise_error
    end
  end  
end  