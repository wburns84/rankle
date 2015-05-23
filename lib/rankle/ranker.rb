module Rankle
  class Ranker
    def self.put klass, proc
      @rankers ||= {}
      @rankers[klass] = proc
    end

    def self.get klass
      @rankers[klass] rescue nil
    end

    def self.swap(first_index, second_index)
      first_index_position = first_index.indexable_position
      first_index.update_attribute(:indexable_position, second_index.indexable_position)
      second_index.update_attribute(:indexable_position, first_index_position)
    end
  end
end