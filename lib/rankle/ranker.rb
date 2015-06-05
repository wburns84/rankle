module Rankle
  MIN_INDEX = -2147483648
  MAX_INDEX =  2147483647

  class Ranker
    attr_accessor :strategy

    def initialize strategy
      @strategy = strategy
    end

    def self.insert target_position, existing_elements
      return target_position, existing_elements
    end
  end
end