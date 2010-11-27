module Accumulators
  class Count
    attr_reader :count

    def initialize
      @count = 0
    end

    def add(rhs)
      if rhs.is_a? Accumulators::Count
        @count += rhs.count
      else
        @count += 1
      end
    end
  end
end

