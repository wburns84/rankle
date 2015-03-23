require "rankle/version"
require 'active_record'

module Rankle
  module ClassMethods
    def rank
      #RankleIndex.includes(:indexable).where(indexable_type: self).order(:position)
      #self.joins(:indexable).where(indexable_type: self)#.order(:position)
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
      RankleIndex.where(indexable_id: id, indexable_type: self.class).first_or_create.update_attribute(:position, position)
    end
  end
end

ActiveRecord::Base.extend Rankle::ClassMethods
ActiveRecord::Base.send :include, Rankle::InstanceMethods
