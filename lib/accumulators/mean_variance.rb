
module Accumulators
  class MeanVariance
    attr_reader :count, :mean, :sumsq

    def initialize
      @count = 0
      @mean = 0.0
      @sumsq = 0.0
    end

    def add(rhs)
      if rhs.is_a? Numeric
        @count += 1
        delta = rhs - @mean
        @mean += delta/@count
        @sumsq += delta * (rhs - @mean)
      elsif rhs.is_a? MeanVariance
        if rhs.count > 0
          newCount = @count + rhs.count
          delta = rhs.mean - @mean

          newMean = @mean + delta*rhs.count/newCount
          newSumsq = @sumsq + rhs.sumsq + delta*delta*@count*rhs.count/newCount

          @count = newCount
          @mean = newMean
          @sumsq = newSumsq
        end
      else
        raise ArgumentError
      end
    end

    def variance
      @count > 1 ? (@sumsq / (@count)) : 0.0
    end

    def stddev
      Math.sqrt(variance)
    end

  end
end
