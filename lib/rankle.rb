require 'active_record'
require 'rankle/ranker'
require 'rankle/version'

# Rankle provides multi-resource ranking for ActiveRecord objects.
#
# This top-level module provides a namespace for all Rankle code.
#
# @author William Burns
module Rankle
  # Class methods added to ActiveRecord models
  module ClassMethods
    # @return [ActiveRecord::Relation]
    def ranked name = :default
      ranked_results = joins("INNER JOIN rankle_indices ON rankle_indices.indexable_name = '#{name}' AND
                                                           rankle_indices.indexable_id   = #{self.to_s.tableize}.id AND
                                                           rankle_indices.indexable_type = '#{self.to_s}'")
      if ranked_results.size == 0
        self.all
      else
        ranked_results.order('rankle_indices.indexable_position')
      end
    end

    def ranks proc
      Ranker.put self, proc
    end
  end

  def self.ranked name = :default
    RankleIndex.where(indexable_name: name).order(:indexable_position).map do |duck|
      duck.indexable_type.classify.constantize.find(duck.indexable_id)
    end
  end

  # instance methods added to ActiveRecord models
  module InstanceMethods
    def set_default_position
      if Ranker.get(self.class)
        position = self.class.ranked.each_with_index { |record, index| break index if Ranker.get(self.class).call(self, record) }
      end unless Ranker.get(self.class).is_a?(Symbol)
      position = self.class.count - 1 if position.nil? || position.is_a?(Array)
      rank position
      if Ranker.get(self.class).is_a?(Symbol)
        rank Ranker.get(self.class), RankleIndex.where(indexable_name: Ranker.get(self.class)).count
      end
    end

    # Assigns an explicit position to the record
    #
    # @param format [Integer] the new position
    # @return [Integer or Exception] the new position or an exception if the position could not be set
    def position= position
      rank position
    end

    def rank name = :default, position
      rankle_index = RankleIndex.where(indexable_name: name.to_s, indexable_id: id, indexable_type: self.class).first_or_create!
      rankle_index_length = if name == :default
        RankleIndex.where(indexable_name: name.to_s, indexable_type: self.class).count
      else
        RankleIndex.where(indexable_name: name.to_s).count
      end
      position = 0 if position < 0
      position = rankle_index_length - 1 if position >= rankle_index_length
      rankle_index.update_attribute(:indexable_position, rankle_index_length - 1) unless rankle_index.indexable_position
      swap_distance  = -1
      swap_distance *= -1 if rankle_index.indexable_position < position
      until rankle_index.indexable_position == position
        if name == :default
          Ranker.swap(rankle_index, RankleIndex.where(indexable_name: name.to_s, indexable_type: self.class, indexable_position: rankle_index.indexable_position + swap_distance).first)
        else
          Ranker.swap(rankle_index, RankleIndex.where(indexable_name: name.to_s, indexable_position: rankle_index.indexable_position + swap_distance).first)
        end
      end
    end

    def position name = :default
      RankleIndex.where(indexable_name: name.to_s, indexable_id: id, indexable_type: self.class).first_or_create.indexable_position
    end
  end
end

ActiveRecord::Base.extend Rankle::ClassMethods
ActiveRecord::Base.send :include, Rankle::InstanceMethods

class ActiveRecord::Base
  def self.inherited(child)
    super
    unless child == ActiveRecord::SchemaMigration || child == RankleIndex
      child.send :after_create, :set_default_position
    end
  end
end
