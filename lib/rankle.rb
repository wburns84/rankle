require 'active_record'
require 'rankle/ranker'
require 'rankle/version'

module Rankle
  module ClassMethods
    def rank
      ranked_results = joins("INNER JOIN rankle_indices ON rankle_indices.indexable_id = #{self.to_s.tableize}.id AND rankle_indices.indexable_type = '#{self.to_s}'")
      if ranked_results.size == 0
        self
      else
        ranked_results.order("rankle_indices.position")
      end
    end
  end

  module InstanceMethods
    def order= position
      position = 0 if position < 0
      rankle_index = RankleIndex.where(indexable_id: id, indexable_type: self.class).first_or_create
      unless rankle_index.position == position
        rankle_index_length = RankleIndex.where(indexable_type: self.class).count
        rankle_index.update_attribute(:position, rankle_index_length - 1)
      end
      swap_distance  = -1
      swap_distance *= -1 if rankle_index.position < position
      until rankle_index.position == position
        Ranker.swap(rankle_index, RankleIndex.where(indexable_type: self.class, position: rankle_index.position + swap_distance).first)
      end
    end
  end
end

ActiveRecord::Base.extend Rankle::ClassMethods
ActiveRecord::Base.send :include, Rankle::InstanceMethods
