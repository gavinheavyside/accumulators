require 'spec_helper'

module Accumulators
  describe MinMax do
    let(:minmax){ MinMax.new }

    context "Creation" do
      it "can be created" do
        lambda{ MinMax.new }.should_not raise_error
      end

      it "returns a min and max of nil before anything is added to it" do
        minmax.min.should be_nil
        minmax.max.should be_nil
      end
    end

    context "adding numbers or distributions" do
      it "allows integers to be added" do
        lambda { minmax.add 5 }.should_not raise_error
      end

      it "allows floats to be added" do
        lambda { minmax.add 3.4 }.should_not raise_error
      end

      it "allows other MinMax distributions to be added" do
        lambda { minmax.add MinMax.new }.should_not raise_error
      end

      it "raises an ArgumentError if a String is added" do
        lambda { minmax.add "1.5" }.should raise_error(
          ArgumentError,
          "You may not add String to Accumulators::MinMax")
      end
    end

    context "correctness of int min/max" do
      it "returns Integer -3, 76 when 3,23,-3,-2,75,76,1 are added" do
        [3,23,-3,-2,75,76,1].each{|n| minmax.add n }
        minmax.min.should be_a Integer
        minmax.min.should == -3
        minmax.max.should be_a Integer
        minmax.max.should == 76
      end
    end

    context "correctness of float min/max" do
      it "returns Integer -3.2, 76.2 when 3.2,23.2,-3.2,-2.2,75.2,76.2,1.2 are added" do
        [3.2,23.2,-3.2,-2.2,75.2,76.2,1.2].each{|n| minmax.add n }
        minmax.min.should be_a Float
        minmax.min.should == -3.2
        minmax.max.should be_a Float
        minmax.max.should == 76.2
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
        minmax.min.class.should == vals.min.class
        minmax.min.should == vals.min
        minmax.max.class.should == vals.max.class
        minmax.max.should == vals.max
      end
    end
  end
end
