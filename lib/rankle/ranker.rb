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
      elsif target_position > existing_elements.count
        return (MAX_INDEX + existing_elements.last) / 2, existing_elements
      elsif existing_elements[target_position] - existing_elements[target_position - 1] > 0
        return (existing_elements[target_position] + existing_elements[target_position - 1]) / 2, existing_elements
      end
    end

    def self.balance indices, options = {}
      min_index = options[:min_index] || MIN_INDEX
      max_index = options[:max_index] || MAX_INDEX
      offset = (max_index - min_index) / (indices.count + 1)
      indices.count.times.map { |index| min_index + (offset * (index + 1)) + index }
    end
  end
end