require 'spec_helper'

module Accumulators
  describe Count do
    let(:count){Count.new}

    context "Creation" do
      it "can be created" do
        expect{ Count.new }.not_to raise_error
      end

      it "returns count of 0 before anything is added to it" do
        expect(Count.new.count).to eq(0)
      end
    end

    context "adding numbers or distributions" do
      it "allows integers to be added" do
        expect{count.add 5}.not_to raise_error
      end

      it "allows floats to be added" do
        expect{count.add 3.4}.not_to raise_error
      end

      it "allows other Count distributions to be added" do
        c2 = Count.new
        expect{count.add c2}.not_to raise_error
      end

      it "allows strings to be added" do
        expect{count.add "1.5"}.not_to raise_error
      end
    end

    context "correctness of item additions" do
      it "should return a count of 1 when a single item is added" do
        count.add 5
        expect(count.count).to eq(1)
      end

      it "should return the count of how many items have been added" do
        1.upto(1000) do |i|
          count.add i
          expect(count.count).to eq(i)
        end
      end
    end

    context "correctness of accumulator additions" do
      it "should combine two Count accumulators correctly" do
        c2 = Count.new
        10.times{ c2.add 1; count.add 1 }
        count.add(c2)
        expect(count.count).to eq(20)
      end
    end
  end
end

