require_relative '../support/test_helper'

describe RankleIndex do
  describe 'position' do
    describe 'when 1 record' do
      describe 'when indexable_position is 0' do
        it 'returns 0' do
          apple = Fruit.create! name: 'apple'
          RankleIndex.first.update_attribute :indexable_position, 0
          assert_equal 0, apple.position
        end
      end

      describe 'when indexable_position is 11' do
        it 'returns 0' do
          apple = Fruit.create! name: 'apple'
          RankleIndex.first.update_attribute :indexable_position, 11
          assert_equal 0, apple.position
        end
      end
    end
  end
end
