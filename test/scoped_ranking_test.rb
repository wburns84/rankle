require_relative './support/test_helper'

class TestScopedRanking < Minitest::Test
  def test_it_ranks_relative_to_a_scope
    Fruit.class_exec { scope :berries, -> { where "name LIKE ?", '%berry' } }

    ['apple', 'apricot', 'banana', 'bilberry', 'blackberry', 'blackcurrant', 'blueberry', 'boysenberry', 'cantaloupe'].each do |name|
      Fruit.create! name: name
    end

    assert_equal ['apple', 'apricot', 'banana', 'bilberry', 'blackberry', 'blackcurrant', 'blueberry', 'boysenberry', 'cantaloupe'], Fruit.ranked.map(&:name)
    assert_equal ['bilberry', 'blackberry', 'blueberry', 'boysenberry'], Fruit.berries.ranked.map(&:name)
  end
end
