require 'ranked-model'
require_relative './rankle/queries/position_query'

class RankleIndex < ActiveRecord::Base
  include RankedModel

  ranks :row_order, column: :indexable_position, :with_same => :indexable_name

  belongs_to :indexable, polymorphic: true

  @rankers = {}

  def self.ranks klass, ranker
    @rankers[klass] = ranker
  end

  def self.set_default_position instance
    if @rankers[instance.class] && @rankers[instance.class].strategy
      position = instance.class.ranked.each_with_index { |record, index| break index if @rankers[instance.class].strategy.call(instance, record) } unless @rankers[instance.class].strategy.is_a?(Symbol)
    end
    position = instance.class.count - 1 if position.nil? || position.is_a?(Array)
    instance.rank position
    if @rankers[instance.class] && @rankers[instance.class].strategy.is_a?(Symbol)
      instance.rank @rankers[instance.class].strategy, RankleIndex.where(indexable_name: @rankers[instance.class].strategy).count
    end
  end

  def self.rank instance, name, position
    existing_indices = if name == :default
                            RankleIndex.where indexable_name: name.to_s, indexable_type: instance.class
                          else
                            RankleIndex.where indexable_name: name.to_s
                          end
    position = existing_indices.length - 1 if position > existing_indices.length
    position = 0 if position < 0
    index = RankleIndex.where(indexable_name: name.to_s, indexable_id: instance.id, indexable_type: instance.class).first_or_create!
    index.update_attribute(:row_order_position, position)
  end

  def self.position instance, name
    indexable_position = where(indexable_name: name.to_s, indexable_id: instance.id, indexable_type: instance.class).first_or_create!.indexable_position
    indexable_scope = where(indexable_name: name.to_s)
    indexable_scope = indexable_scope.where(indexable_type: instance.class) if name == :default
    indexable_scope = indexable_scope.where('indexable_position < ?', indexable_position)
    indexable_scope.count
  end

  def self.ranked name
    where(indexable_name: name).order(:indexable_position).map do |duck|
      duck.indexable_type.classify.constantize.find(duck.indexable_id)
    end
  end
end
