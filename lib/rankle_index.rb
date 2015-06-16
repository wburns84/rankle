class RankleIndex < ActiveRecord::Base
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
    index = RankleIndex.where(indexable_name: name.to_s, indexable_id: instance.id, indexable_type: instance.class).first_or_initialize
    existing_positions = existing_indices.pluck(:indexable_position).compact
    existing_positions -= [index.indexable_position] unless index.new_record?
    indexable_position, existing_positions = Rankle::Ranker.insert(position, existing_positions)
    existing_positions.each_with_index do |position, index|
      existing_indices[index].update_attribute(:indexable_position, position) unless existing_indices[index].indexable_position = position
    end
    index.indexable_position = indexable_position
    index.save!
  end

  def self.position instance, name
    indexable_position = where(indexable_name: name.to_s, indexable_id: instance.id, indexable_type: instance.class).first_or_create!.indexable_position
    where(indexable_name: name.to_s).where('indexable_position < ?', indexable_position).count
  end

  def self.ranked name
    where(indexable_name: name).order(:indexable_position).map do |duck|
      duck.indexable_type.classify.constantize.find(duck.indexable_id)
    end
  end
end
