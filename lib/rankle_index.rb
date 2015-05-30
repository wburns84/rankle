require 'ranked-model'

class RankleIndex < ActiveRecord::Base
  belongs_to :indexable, polymorphic: true

  def self.update_position instance, name, position
    rankle_index = RankleIndex.where(indexable_name: name.to_s, indexable_id: instance.id, indexable_type: instance.class).first_or_create!
    rankle_index_length = if name == :default
                            RankleIndex.where(indexable_name: name.to_s, indexable_type: instance.class).count
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
        swap(rankle_index, RankleIndex.where(indexable_name: name.to_s, indexable_type: instance.class, indexable_position: rankle_index.indexable_position + swap_distance).first)
      else
        swap(rankle_index, RankleIndex.where(indexable_name: name.to_s, indexable_position: rankle_index.indexable_position + swap_distance).first)
      end
    end
  end

  def self.position instance, name
    where(indexable_name: name.to_s, indexable_id: instance.id, indexable_type: instance.class).first_or_create!.indexable_position
  end

  def self.ranked name
    where(indexable_name: name).order(:indexable_position).map do |duck|
      duck.indexable_type.classify.constantize.find(duck.indexable_id)
    end
  end

  def self.swap(first_index, second_index)
    first_index_position = first_index.indexable_position
    first_index.update_attribute(:indexable_position, second_index.indexable_position)
    second_index.update_attribute(:indexable_position, first_index_position)
  end
end
