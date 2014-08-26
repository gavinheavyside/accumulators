require 'spec_helper'

module Accumulators
  describe MinMax do
    let(:minmax){ MinMax.new }

    context "Creation" do
      it "can be created" do
        expect{ MinMax.new }.not_to raise_error
      end

      it "returns a min and max of nil before anything is added to it" do
        expect(minmax.min).to be_nil
        expect(minmax.max).to be_nil
      end
    end

    context "adding numbers or distributions" do
      it "allows integers to be added" do
        expect { minmax.add 5 }.not_to raise_error
      end

      it "allows floats to be added" do
        expect { minmax.add 3.4 }.not_to raise_error
      end

      it "allows other MinMax distributions to be added" do
        expect { minmax.add MinMax.new }.not_to raise_error
      end

      it "raises an ArgumentError if a String is added" do
        expect { minmax.add "1.5" }.to raise_error(
          ArgumentError,
          "You may not add String to Accumulators::MinMax")
      end
    end

    context "correctness of int min/max" do
      it "returns Integer -3, 76 when 3,23,-3,-2,75,76,1 are added" do
        [3,23,-3,-2,75,76,1].each{|n| minmax.add n }
        expect(minmax.min).to be_a Integer
        expect(minmax.min).to eq(-3)
        expect(minmax.max).to be_a Integer
        expect(minmax.max).to eq(76)
      end
    end

    context "correctness of float min/max" do
      it "returns Integer -3.2, 76.2 when 3.2,23.2,-3.2,-2.2,75.2,76.2,1.2 are added" do
        [3.2,23.2,-3.2,-2.2,75.2,76.2,1.2].each{|n| minmax.add n }
        expect(minmax.min).to be_a Float
        expect(minmax.min).to eq(-3.2)
        expect(minmax.max).to be_a Float
        expect(minmax.max).to eq(76.2)
      end
    end

    context "Correctness of MinMax additions" do
      it "combines two MinMaxes correctly" do
        mm2 = MinMax.new
        vals = []
        500.times do 
          vals << rand * 1000*1000
          minmax.add vals.last
          vals << rand(100*1000)
          mm2.add vals.last
        end

        minmax.add(mm2)
        expect(minmax.min.class).to eq(vals.min.class)
        expect(minmax.min).to eq(vals.min)
        expect(minmax.max.class).to eq(vals.max.class)
        expect(minmax.max).to eq(vals.max)
      end
    end
  end
end
