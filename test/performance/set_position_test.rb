require_relative '../support/test_helper'

class TestSetPosition < Minitest::Test
  def test_initializing_position_makes_six_queries
    assert_queries(10) do
      apple  = Fruit.create! name: 'apple'
    end
  end

  def test_update_position_makes_three_queries
    apple  = Fruit.create! name: 'apple'

    assert_queries(6) do
      apple.update_attribute :position, 1
    end
  end

  def test_update_rank_makes_three_queries
    apple  = Fruit.create! name: 'apple'

    assert_queries(6) do
      apple.rank 1
    end
  end

  def test_initializing_position_with_a_proc_makes_eight_queries
    Fruit.send :ranks, ->(a, b) { a.name < b.name }

    assert_queries(13) do
      Fruit.create! name: 'apple'
    end
  end
end
