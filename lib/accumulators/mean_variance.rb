
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
        raise ArgumentError.new("You may not add #{rhs.class} to #{self.class}")
      end
    end

    def variance(options = {})
      if options[:type] and not [:sample, :population].include? options[:type]
        raise ArgumentError.new("type must be one of :sample, :population")
      end

      if options[:type] == :population
        @count > 1 ? (@sumsq / (@count)) : 0.0
      else
        @count > 1 ? (@sumsq / (@count + 1)) : 0.0
      end
    end

    def stddev(options = {})
      Math.sqrt(variance(options))
    end

  end
end
