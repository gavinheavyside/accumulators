
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
        raise ArgumentError.new("You may not add #{rhs.class} to #{self.class}")
      end
    end
  end
end

