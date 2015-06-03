require_relative '../support/test_helper'
require 'minitest/benchmark'

class BenchmarkRank < Minitest::Benchmark
  def self.bench_range
    Minitest::Benchmark.bench_exp 8, 256, 2
  end

  def bench_insert_has_linear_performance
    assert_performance_linear 0.99 do |n|
      1.times do
        DatabaseCleaner.clean
        n.times { |name| Fruit.create! name: name }
      end
    end

    DatabaseCleaner.clean
  end
end
