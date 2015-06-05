module Rankle
  MIN_INDEX = -2147483648
  MAX_INDEX =  2147483647

  class Ranker
    attr_accessor :strategy

    def initialize strategy
      @strategy = strategy
    end

    def self.insert target_position, existing_elements
      if existing_elements.empty?
        return 0, []
      elsif target_position <= 0
        return (MIN_INDEX + existing_elements.first) / 2, existing_elements
      else
        return (MAX_INDEX + existing_elements.last) / 2, existing_elements
      end
    end
  end
end