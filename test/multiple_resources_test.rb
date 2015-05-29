require_relative './support/test_helper'

class TestNamedRanking < Minitest::Test
  def test_it_ranks_multiple_resources_together
    apple  = Fruit.create!     name: 'apple'
    carrot = Vegetable.create! name: 'carrot'

    apple.rank  :produce, 0
    carrot.rank :produce, 1

    assert_equal 0, apple.position
    assert_equal 0, carrot.position

    assert_equal 0, apple.position(:produce)
    assert_equal 1, carrot.position(:produce)

    assert_equal ['apple'], Fruit.ranked.map(&:name)
    assert_equal ['carrot'], Vegetable.ranked.map(&:name)
  end

  def test_it_does_not_expand_scope
    apple  = Fruit.create!     name: 'apple'
    carrot = Vegetable.create! name: 'carrot'

    apple.rank  :produce, 0
    carrot.rank :produce, 1

    assert_equal 0, apple.position
    assert_equal 0, carrot.position

    assert_equal 0, apple.position(:produce)
    assert_equal 1, carrot.position(:produce)

    assert_equal ['apple'], Fruit.ranked(:produce).map(&:name)
    assert_equal ['carrot'], Vegetable.ranked(:produce).map(&:name)
  end

  def test_it_can_access_the_global_scope
    apple  = Fruit.create!     name: 'apple'
    carrot = Vegetable.create! name: 'carrot'

    apple.rank  :produce, 0
    carrot.rank :produce, 1

    assert_equal 0, apple.position
    assert_equal 0, carrot.position

    assert_equal 0, apple.position(:produce)
    assert_equal 1, carrot.position(:produce)

    assert_equal ['apple', 'carrot'], Rankle.ranked(:produce).map(&:name)
  end

  def test_it_will_initialize_named_rankings_across_multiple_resources
    Fruit.send     :ranks, :produce
    Vegetable.send :ranks, :produce

    apple  = Fruit.create!     name: 'apple'
    carrot = Vegetable.create! name: 'carrot'

    assert_equal 0, apple.position
    assert_equal 0, carrot.position

    assert_equal 0, apple.position(:produce)
    assert_equal 1, carrot.position(:produce)

    # FIXME: This unfortunate hack reaches into the internals of Rankle::Ranker to reset the test state
    Rankle::Ranker.instance_variable_get(:@rankers)[Fruit] = nil
  end
end
