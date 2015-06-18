require_relative '../support/test_helper'

class TestGetPosition < Minitest::Test
  def test_retrieving_position_makes_only_one_query
    apple  = Fruit.create! name: 'apple'

    assert_queries(1) do
      apple.position
    end
  end
end
