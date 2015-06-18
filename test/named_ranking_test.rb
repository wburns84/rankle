require_relative './support/test_helper'

class TestNamedRanking < Minitest::Test
  def test_it_sets_the_position_for_the_named_ranking
    apple  = Fruit.create! name: 'apple'
    orange = Fruit.create! name: 'orange'

    apple.rank  :reverse, 1
    orange.rank :reverse, 0

    assert_equal 0, apple.position
    assert_equal 1, orange.position

    assert_equal 1, apple.position(:reverse)
    assert_equal 0, orange.position(:reverse)

    assert_equal ['apple', 'orange'], Fruit.ranked.map(&:name)
    assert_equal ['orange', 'apple'], Fruit.ranked(:reverse).map(&:name)
  end

  def test_it_does_not_initialize_named_rankings
    apple  = Fruit.create! name: 'apple'
    banana = Fruit.create! name: 'banana'
    orange = Fruit.create! name: 'orange'

    apple.rank  :reverse, 2
    banana.rank :reverse, 1
    orange.rank :reverse, 0

    assert_equal 0, apple.position
    assert_equal 1, banana.position
    assert_equal 2, orange.position

    assert_equal 1, apple.position(:reverse)
    assert_equal 2, banana.position(:reverse)
    assert_equal 0, orange.position(:reverse)

    assert_equal ['apple', 'banana', 'orange'], Fruit.ranked.map(&:name)
    assert_equal ['orange', 'apple', 'banana'], Fruit.ranked(:reverse).map(&:name)
  end

  def test_it_initializes_registered_named_rankings
    Fruit.send :ranks, :reverse

    apple  = Fruit.create! name: 'apple'
    banana = Fruit.create! name: 'banana'
    orange = Fruit.create! name: 'orange'

    assert_equal 0, apple.position
    assert_equal 1, banana.position
    assert_equal 2, orange.position

    assert_equal 0, apple.position(:reverse)
    assert_equal 1, banana.position(:reverse)
    assert_equal 2, orange.position(:reverse)

    apple.rank  :reverse, 2
    banana.rank :reverse, 1
    orange.rank :reverse, 0

    assert_equal 0, apple.position
    assert_equal 1, banana.position
    assert_equal 2, orange.position

    assert_equal 2, apple.position(:reverse)
    assert_equal 1, banana.position(:reverse)
    assert_equal 0, orange.position(:reverse)

    assert_equal ['apple', 'banana', 'orange'], Fruit.ranked.map(&:name)
    assert_equal ['orange', 'banana', 'apple'], Fruit.ranked(:reverse).map(&:name)
  end
end
