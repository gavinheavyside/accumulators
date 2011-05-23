require 'spec_helper'

module Accumulators
  describe MeanVariance do
    let(:meanvar){MeanVariance.new}

    context "When creating" do
      it "can be created" do
        lambda{ MeanVariance.new }.should_not raise_error
      end

      it "returns count,mean,var of 0,0.0,0.0 before anything is added" do
        meanvar.count.should == 0
        meanvar.mean.should be_within(EPSILON).of(0.0)
        meanvar.variance(type: :population).should be_within(EPSILON).of(0.0)
      end
    end

    context "When adding numbers or distributions" do
      it "allows integers to be added" do
        lambda{ meanvar.add 5 }.should_not raise_error
      end

      it "allows floats to be added" do
        lambda{ meanvar.add 5.5 }.should_not raise_error
      end

      it "allows other MeanVar distributions to be added" do
        lambda{ meanvar.add MeanVariance.new }.should_not raise_error
      end

      it "raises an ArgumentError if a string is added" do
        lambda{ meanvar.add "1.5" }.should raise_error(
          ArgumentError,
          "You may not add String to Accumulators::MeanVariance")
      end

      it "raises an ArgumentError if a Mean accumulator is added" do
        lambda{ meanvar.add Mean.new }.should raise_error(
          ArgumentError,
          "You may not add Accumulators::Mean to Accumulators::MeanVariance")
      end

      it "raises an ArgumentError if an unknown type of variance is requested" do
        lambda{ meanvar.variance(type: :unknown) }.should raise_error(
          ArgumentError,
          "type must be one of :sample, :population")
      end
    end

    context "When checking correctness of biased/population calculations" do
      before do
        @vals = []
        1000.times do
          @vals << rand * 10000
          meanvar.add @vals.last
        end
      end

      it "calculates the count and mean correctly for a set of numbers" do
        meanvar.count.should == @vals.size
        meanvar.mean.should be_within(EPSILON).of(@vals.reduce(:+)/@vals.size)
      end

      it "calculates the population variance and stddev correctly" do
        variance = @vals.map{|v| (v - meanvar.mean)**2}.reduce(:+) / @vals.size 
        meanvar.variance(type: :population).should be_within(EPSILON).of(variance)
        meanvar.stddev(type: :population).should be_within(EPSILON).of(Math.sqrt(variance))
      end

      it "calculates the sample variance and stddev correctly" do
        variance = @vals.map{|v| (v - meanvar.mean)**2}.reduce(:+) / (@vals.size + 1)
        meanvar.variance(type: :sample).should be_within(EPSILON).of(variance)
        meanvar.stddev(type: :sample).should be_within(EPSILON).of(Math.sqrt(variance))
      end

      it "defaults to sample variance" do
        meanvar.variance.should be_within(EPSILON).of(meanvar.variance(type: :sample))
      end
    end

    context "When combining MeanVariances" do
      it "combines two MeanVariances correctly" do
        vals = []
        mv2 = MeanVariance.new
        500.times do
          vals << rand * 10000
          meanvar.add vals.last
          vals << rand * 1000
          mv2.add vals.last
        end

        meanvar.add(mv2)

        meanvar.count.should == vals.size
        meanvar.mean.should be_within(EPSILON).of(vals.reduce(:+)/vals.size)
        meanvar.variance(type: :population).should be_within(EPSILON).of(vals.map{|v| (v - meanvar.mean)**2}.reduce(:+) / vals.size)
      end
    end

  end
end
