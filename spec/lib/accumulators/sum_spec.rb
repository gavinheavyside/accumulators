require 'spec_helper'

module Accumulators
  describe Sum do
    let(:sum){ Sum.new }

    context "Creation" do
      it "can be created" do
        lambda{ Sum.new }.should_not raise_error
      end

      it "returns a sum of 0 before anything is added to it" do
        sum.sum.should == 0
      end
    end

    context "adding numbers or distributions" do
      it "allows integers to be added" do
        lambda { sum.add 5 }.should_not raise_error
      end

      it "allows floats to be added" do
        lambda { sum.add 3.4 }.should_not raise_error
      end

      it "allows other Sum distributions to be added" do
        lambda { sum.add Sum.new }.should_not raise_error
      end

      it "raises an ArgumentError if a String is added" do
        lambda { sum.add "1.5" }.should raise_error(
          ArgumentError,
          "You may not add String to Accumulators::Sum")
      end
    end

    context "Correctness of int additions" do
      it "should return an Integer 6 when 1,2,3 is added" do
        (1..3).each{ |i| sum.add i }

        sum.sum.should be_a Integer
        sum.sum.should == 6
      end
      
      it "should calculate the sum correctly for a set of 1000 random integers" do
        vals = []
        1000.times do 
          vals << rand(100000)
          sum.add vals.last
        end
        sum.sum.should be_a Integer
        sum.sum.should == vals.reduce(:+)
      end
    end

    context "Correctness of float additions" do
      it "should return a Float 6.1 when 1.1, 2.8, 2.2 is added" do
        [1.1,2.8,2.2].each{|f| sum.add f}

        sum.sum.should be_a Float
        sum.sum.should be_within(EPSILON).of(6.1)
      end

      it "should calculate the sum correctly for a set of 1000 random floats" do
        vals = []
        1000.times do
          vals << rand * 1000000
          sum.add vals.last
        end

        sum.sum.should be_a Float
        sum.sum.should be_within(EPSILON).of(vals.reduce(:+))
      end
    end

    context "Correctness of accumulator additions" do
      it "combines two sums correctly" do
        s2 = Sum.new
        vals = []
        500.times do 
          vals << rand * 1000*1000
          sum.add vals.last
          vals << rand * 100*1000
          s2.add vals.last
        end

        sum.add(s2)
        sum.sum.should be_a Float
        sum.sum.should be_within(EPSILON).of(vals.reduce(:+))
      end
    end
  end
end
