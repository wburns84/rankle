class PositionQuery < Struct.new(:position)
  def initialize instance, name
    query = count_less_than instance, name
    self.position = ActiveRecord::Base.connection.execute(query.to_sql)[0][0]
  end

  private

  def count_less_than instance, name
    table.
      project(Arel.star.count).
      where(indexable_name(name).
      and(indexable_position(instance, name)))
  end

  def indexable_position instance, name
    table[:indexable_position].lt(indexable_position_query instance, name)
  end

  def indexable_position_query instance, name
    table.
      project(:indexable_position).
      where(indexable_name(name).
      and(indexable_id(instance.id).
      and(indexable_type(instance.class))))
  end

  def indexable_name name
    table[:indexable_name].eq(name.to_s)
  end

  def indexable_type type
    table[:indexable_type].eq(type)
  end

  def indexable_id id
    table[:indexable_id].eq(id)
  end

  def table
    RankleIndex.arel_table
  end
end
