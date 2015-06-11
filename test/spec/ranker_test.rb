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

    describe 'between non-adjacent elements' do
      it{ assert_equal [0, [-1, 1]], Rankle::Ranker.insert(1, [-1, 1]) }
      it{ assert_equal [0, [-1, 2]], Rankle::Ranker.insert(1, [-1, 2]) }
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

    describe 'collision' do
      it{ assert_equal [0, [-715827883, 715827883]], Rankle::Ranker.insert(1, [-1, 0]) }
      it{ assert_equal [0, [-715827883, 715827883]], Rankle::Ranker.insert(1, [ 0, 1]) }
    end

    describe 'cascading collision' do
      it{ assert_equal [-858993459, [-1288490189, -429496729, 429496731, 1288490191]], Rankle::Ranker.insert(1, [-2, -1, 0, 1]) }
      it{ assert_equal [-858993459, [-1288490189, -429496729, 429496731, 1288490191]], Rankle::Ranker.insert(1, [-1,  0, 1, 2]) }
    end

    describe 'half-saturated' do
      before do
        @min_index = Rankle::Ranker::MIN_INDEX
        @max_index = Rankle::Ranker::MAX_INDEX
        Rankle::Ranker.send :remove_const, :MIN_INDEX
        Rankle::Ranker.send :remove_const, :MAX_INDEX
        Rankle::Ranker::MIN_INDEX = -2
        Rankle::Ranker::MAX_INDEX = 2
      end

      it{ assert_equal [-1, [-2, 0, 2]], Rankle::Ranker.insert(1, [-2, 0, 2]) }
      it{ assert_equal [1, [-2, 0, 2]], Rankle::Ranker.insert(2, [-2, 0, 2]) }

      after do
        Rankle::Ranker.send :remove_const, :MIN_INDEX
        Rankle::Ranker.send :remove_const, :MAX_INDEX
        Rankle::Ranker::MIN_INDEX = @min_index
        Rankle::Ranker::MAX_INDEX = @max_index
      end
    end
  end

  describe '.balance' do
    describe 'with default range' do
      before do
        @indices = {
          [-1073741824] => [-1],
          [1073741823]  => [-1],
          [-1, 1]       => [-715827883, 715827883]
        }
      end

      it do
        @indices.each do |indices, expected|
          assert_equal expected, Rankle::Ranker.balance(indices)
        end
      end
    end

    describe 'with custom range' do
      it{ assert_equal [3, 7], Rankle::Ranker.balance([0, 1], min_index: 0, max_index: 10) }
    end
  end
end
