require_relative '../support/test_helper'

describe Rankle::Ranker do
  describe '.insert into' do
    describe 'empty array' do
      describe 'at position 0' do
        it{ assert_equal [0, []], Rankle::Ranker.insert(0, []) }
      end

      describe 'at position -100' do
        it{ assert_equal [0, []], Rankle::Ranker.insert(-100, []) }
      end

      describe 'at position 100' do
        it{ assert_equal [0, []], Rankle::Ranker.insert(100, []) }
      end
    end

    describe 'singleton array' do
      describe 'at position 0' do
        it{ assert_equal [-1073741824, [0]], Rankle::Ranker.insert(0, [0]) }
      end

      describe 'at position -100' do
        it{ assert_equal [-1073741824, [0]], Rankle::Ranker.insert(-100, [0]) }
      end

      describe 'at position 100' do
        it{ assert_equal [1073741823, [0]], Rankle::Ranker.insert(100, [0]) }
      end
    end

    describe 'saturated' do
      before do
        @min_index = Rankle::Ranker::MIN_INDEX
        @max_index = Rankle::Ranker::MAX_INDEX
        Rankle::Ranker.send :remove_const, :MIN_INDEX
        Rankle::Ranker.send :remove_const, :MAX_INDEX
        Rankle::Ranker::MIN_INDEX = -2
        Rankle::Ranker::MAX_INDEX = 2
      end

      it{ assert_raises(IndexError) { Rankle::Ranker.insert(0, [-2, -1, 0, 1, 2]) } }

      after do
        Rankle::Ranker.send :remove_const, :MIN_INDEX
        Rankle::Ranker.send :remove_const, :MAX_INDEX
        Rankle::Ranker::MIN_INDEX = @min_index
        Rankle::Ranker::MAX_INDEX = @max_index
      end
    end
  end
end
