require 'active_record'
require 'rankle_index'
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
    RankleIndex.ranked name
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
      RankleIndex.update_position self, name, position
    end

    def position name = :default
      RankleIndex.position self, name
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
