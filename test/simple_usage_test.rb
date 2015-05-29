require_relative './support/test_helper'

class TestSimpleUsage < Minitest::Test
  def test_it_assigns_an_explicit_ranking
    apple  = Fruit.create! name: 'apple'
    orange = Fruit.create! name: 'orange'

    apple.update_attribute :position, 1

    assert_equal 1, apple.position
    assert_equal 0, orange.position

    assert_equal ['orange', 'apple'], Fruit.ranked.map(&:name)
  end

  def test_it_sets_position_with_the_rank_method
    apple  = Fruit.create! name: 'apple'
    orange = Fruit.create! name: 'orange'

    apple.rank 1

    assert_equal 1, apple.position
    assert_equal 0, orange.position

    assert_equal ['orange', 'apple'], Fruit.ranked.map(&:name)
  end

  def test_it_maintains_rank_with_a_proc
    Fruit.send :ranks, ->(a, b) { a.name < b.name }

    Fruit.create! name: 'apple'
    Fruit.create! name: 'orange'
    Fruit.create! name: 'banana'

    assert_equal ['apple', 'banana', 'orange'], Fruit.ranked.map(&:name)

    # FIXME: This unfortunate hack reaches into the internals of Rankle::Ranker to reset the test state
    Rankle::Ranker.instance_variable_get(:@rankers)[Fruit] = nil
  end
end
