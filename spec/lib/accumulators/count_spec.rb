require 'spec_helper'

module Accumulators
  describe Count do
    let(:count){Count.new}

    context "Creation" do
      it "can be created" do
        lambda{ Count.new }.should_not raise_error
      end

      it "returns count of 0 before anything is added to it" do
        Count.new.count.should == 0
      end
    end

    context "adding numbers or distributions" do
      it "allows integers to be added" do
        lambda{count.add 5}.should_not raise_error
      end

      it "allows floats to be added" do
        lambda{count.add 3.4}.should_not raise_error
      end

      it "allows other Count distributions to be added" do
        c2 = Count.new
        lambda{count.add c2}.should_not raise_error
      end

      it "allows strings to be added" do
        lambda{count.add "1.5"}.should_not raise_error
      end
    end

    context "correctness of item additions" do
      it "should return a count of 1 when a single item is added" do
        count.add 5
        count.count.should == 1
      end

      it "should return the count of how many items have been added" do
        1.upto(1000) do |i|
          count.add i
          count.count.should == i
        end
      end
    end

    context "correctness of accumulator additions" do
      it "should combine two Count accumulators correctly" do
        c2 = Count.new
        10.times{ c2.add 1; count.add 1 }
        count.add(c2)
        count.count.should == 20
      end
    end
  end
end

