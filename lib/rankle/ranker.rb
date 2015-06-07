module Rankle
  class Ranker
    MIN_INDEX = -2147483648
    MAX_INDEX =  2147483647

    attr_accessor :strategy

    def initialize strategy
      @strategy = strategy
    end

    def self.insert target_position, existing_elements
      if existing_elements.count > MAX_INDEX - MIN_INDEX
        raise IndexError
      elsif existing_elements.empty?
        return 0, []
      elsif target_position <= 0
        return (MIN_INDEX + existing_elements.first) / 2, existing_elements
      else
        return (MAX_INDEX + existing_elements.last) / 2, existing_elements
      end
    end

    def self.balance indices
      offset = (MAX_INDEX - MIN_INDEX) / (indices.count + 1)
      indices.count.times.map { |index| MIN_INDEX + offset * (index + 1) + 1 }
    end
  end
end