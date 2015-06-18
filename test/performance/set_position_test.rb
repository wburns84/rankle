require_relative '../support/test_helper'

class TestSetPosition < Minitest::Test
  def test_initializing_position_makes_six_queries
    assert_queries(6) do
      apple  = Fruit.create! name: 'apple'
    end
  end

  def test_update_position_makes_three_queries
    apple  = Fruit.create! name: 'apple'

    assert_queries(3) do
      apple.update_attribute :position, 1
    end
  end

  def test_update_rank_makes_three_queries
    apple  = Fruit.create! name: 'apple'

    assert_queries(3) do
      apple.rank 1
    end
  end
end
