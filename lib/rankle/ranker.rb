module Rankle
  class Ranker
    attr_accessor :strategy

    def initialize strategy
      @strategy = strategy
    end
  end
end