require_relative './support/test_helper'

class TestDefaultBehavior < Minitest::Test
  def test_it_is_ineffectual
    assert(Fruit.all.to_a == Fruit.ranked.to_a)
  end

  def test_it_sets_position
    apple  = Fruit.create!
    orange = Fruit.create!

    assert_equal 0, apple.position
    assert_equal 1, orange.position
  end

  def test_it_ranks_on_insert_order
    Fruit.create! name: 'apple'
    Fruit.create! name: 'orange'

    assert_equal ['apple', 'orange'], Fruit.ranked.map(&:name)
  end
end