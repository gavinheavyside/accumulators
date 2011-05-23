module Accumulators
  class Sum
    attr_reader :sum

    def initialize
      @sum = 0
    end
    
    def add(rhs)
      if rhs.is_a? Numeric
        @sum += rhs
      elsif rhs.is_a? self.class
        @sum += rhs.sum
      else
        raise ArgumentError.new("You may not add #{rhs.class} to #{self.class}")
      end
    end
  end
end
