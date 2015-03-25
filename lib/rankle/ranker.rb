module Rankle
  class Ranker
    def self.swap(first_index, second_index)
      first_index_position = first_index.position
      first_index.update_attribute(:position, second_index.position)
      second_index.update_attribute(:position, first_index_position)
    end
  end
end