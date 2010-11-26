require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

EPSILON = 0.00001

module Accumulators
  class Mean
    attr_reader :count, :mean

    def initialize
      @count = 0
      @mean = 0.0
    end

    def add(rhs)
      if rhs.is_a? Numeric
        value_to_add = rhs.to_f
        @mean = @mean + (value_to_add - @mean)/(@count + 1)
        @count += 1
      elsif rhs.is_a? Accumulators::Mean
        sum = @mean * @count
        rhs_sum = rhs.mean * rhs.count
        @count = @count + rhs.count
        @mean = (sum + rhs_sum) / @count
      else
        raise ArgumentError.new("Can only add numbers to a Mean Accumulator")
      end
    end
  end
end



describe "Accumulators" do
  describe "Mean" do
    context "Creation" do
      it "can be created" do
        lambda{ Accumulators::Mean.new}.should_not raise_error
      end

      it "returns count and mean of 0 before anything is added to it" do
        mean = Accumulators::Mean.new
        mean.count.should == 0
        mean.mean.should be_within(EPSILON).of(0.0)
      end

    end

    context "adding numbers or distributions" do
      before :each do
        @mean = Accumulators::Mean.new
      end

      it "allows integers to be added" do
        lambda{@mean.add 5}.should_not raise_error
      end

      it "allows floats to be added" do
        lambda{@mean.add 3.4}.should_not raise_error
      end

      it "allows other Mean distributions to be added" do
        mean2 = Accumulators::Mean.new
        lambda{@mean.add mean2}.should_not raise_error
      end

      it "raises an ArgumentError if a string is added" do
        lambda{@mean.add "1.5"}.should raise_error(ArgumentError)
      end
    end

    context "correctness of int additions" do
      before :each do
        @mean = Accumulators::Mean.new
      end

      it "should return count of 1 and mean of 5 when 5 is added" do
        @mean.add(5)
        @mean.count.should == 1
        @mean.mean.should be_within(EPSILON).of(5)
      end

      it "should calculate the mean correctly for a set of integers" do
        1.upto(10) {|i| @mean.add i}
        @mean.count.should == 10
        @mean.mean.should be_within(EPSILON).of((1..10).reduce(:+).to_f/10)
      end

      it "should calculate the mean correctly for a random set of 1000 integers" do
        vals = []
        1000.times do
          vals << rand(100000)
          @mean.add(vals.last)
        end

        @mean.mean.should be_within(EPSILON).of(vals.reduce(:+).to_f/vals.size)
      end
    end

    context "correctness of float additions" do
      before :each do
        @mean = Accumulators::Mean.new
      end

      it "should calculate the mean correctly for a set of floats" do
        1.upto(10) {|i| @mean.add i+0.1}
        @mean.count.should == 10
        @mean.mean.should be_within(EPSILON).of((1..10).map{|i| i+0.1}.reduce(:+)/10)
      end

      it "should calculate the mean correctly for a random set of 1000 floats" do
        vals = []
        1000.times do
          vals << rand * 1000000
          @mean.add vals.last
        end
        @mean.mean.should be_within(EPSILON).of(vals.reduce(:+)/vals.size)
      end
    end

    context "correctness of accumulator additions" do
      before :each do
        @mean = Accumulator.new
      end
    end
  end
end
