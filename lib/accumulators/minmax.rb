module Accumulators
  class MinMax
    attr_reader :min
    attr_reader :max

    def add(rhs)
      if rhs.is_a? Numeric
        @min = [@min, rhs].min rescue rhs
        @max = [@max, rhs].max rescue rhs
      elsif rhs.is_a? self.class
        @min = [@min, rhs.min].min rescue rhs.min
        @max = [@max, rhs.max].max rescue rhs.max
      else
        raise ArgumentError.new("You may not add #{rhs.class} to #{self.class}")
      end
    end
  end
end
