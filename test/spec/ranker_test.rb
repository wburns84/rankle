require_relative '../support/test_helper'

describe Rankle::Ranker do
  describe 'insert into' do
    describe 'empty array' do
      describe 'at position 0' do
        it 'returns 0' do
          assert_equal [0, []], Rankle::Ranker.insert(0, [])
        end
      end

      describe 'at position -100' do
        it 'returns 0' do
          assert_equal [0, []], Rankle::Ranker.insert(-100, [])
        end
      end

      describe 'at position 100' do
        it 'returns 0' do
          assert_equal [0, []], Rankle::Ranker.insert(100, [])
        end
      end
    end

    describe 'singleton array' do
      describe 'at position 0' do
        it 'returns -1073741824' do
          assert_equal [-1073741824, [0]], Rankle::Ranker.insert(0, [0])
        end
      end

      describe 'at position -100' do
        it 'returns -1073741824' do
          assert_equal [-1073741824, [0]], Rankle::Ranker.insert(-100, [0])
        end
      end

      describe 'at position 100' do
        it 'returns 1073741823' do
          assert_equal [1073741823, [0]], Rankle::Ranker.insert(100, [0])
        end
      end
    end
  end
end
