require_relative '../support/test_helper'
require 'minitest/benchmark'

class BenchmarkRank < Minitest::Benchmark
  def self.bench_range
    Minitest::Benchmark.bench_exp 16, 256, 2
  end

  def trials
    1
  end


  def bench_insert_has_linear_performance
    assert_performance_linear 0.99 do |n|
      trials.times do
        DatabaseCleaner.clean
        n.times { |name| Fruit.create! name: name }
      end
    end

    DatabaseCleaner.clean
  end

  def bench_reverse_insert_has_power_performance
    Fruit.send :ranks, ->(a, b) { a.name.to_i > b.name.to_i }

    assert_performance_power 0.99 do |n|
      trials.times do
        DatabaseCleaner.clean
        n.times { |name| Fruit.create! name: name }
      end
    end

    # FIXME: This unfortunate hack reaches into the internals of RankleIndex to reset the test state
    RankleIndex.instance_variable_set(:@rankers, {})
    DatabaseCleaner.clean
  end
end
