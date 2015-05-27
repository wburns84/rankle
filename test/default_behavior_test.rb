require_relative './test_helper'

class TestMeme < Minitest::Test
  def test_that_rankle_is_ineffectual
    assert(Fruit.all.to_a == Fruit.ranked.to_a)
  end
end