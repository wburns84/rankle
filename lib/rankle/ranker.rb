module Rankle
  class Ranker
    def self.put klass, proc
      @rankers ||= {}
      @rankers[klass] = proc
    end

    def self.get klass
      @rankers[klass] rescue nil
    end
  end
end