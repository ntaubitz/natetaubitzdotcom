require File.expand_path('../../test_helper', __FILE__)

require 'benchmark'

class ArraysTest < ActiveSupport::TestCase
  setup do
    @arrays = Arrays.new
  end

  test 'all possible sorted arrays are returned' do
    a = [10, 15, 25]
    b = [1, 5, 20, 30]
    results = []
    @arrays.all_possible_sorted_arrays(a, b, results)
    assert results[0] == [10,20]
    assert results[1] == [10,20, 25, 30]
    assert results[2] == [10,30]
    assert results[3] == [15,20]
    assert results[4] == [15,20, 25, 30]
    assert results[5] == [15,30]
    assert results[6] == [25,30]
  end

  test 'find the nth largest value in an array' do
    input = [1,8,9,3,5,10,30,15,19]
    # Sorted [1,3,5,8,9,10,15,19,30]
    # assert 30 == @arrays.largest_value_at(input, 1)
    assert 15 == @arrays.largest_value_at(input, 3)
    assert 5 == @arrays.largest_value_at(input, 7)
    assert 1 == @arrays.largest_value_at(input, 9)
  end

  test 'find the missing value in an array' do
    assert nil == @arrays.missing_value_simple([1,2,3])
    assert 6 == @arrays.missing_value_simple([2,3,4,5,7,8,9,10])
  end

  test 'find a missing value by divide and conquer' do
    assert 12 == @arrays.missing_value_divide_and_conquer([5,6,7,8,9,10,11,13,14])
  end

  test 'divide and conquer is faster' do
    missing = (Random.new().rand * 100000).floor
    input = []
    100000.times do |val|
      input << val unless val == missing
    end

    found = nil
    time = Benchmark.measure {
      found = @arrays.missing_value_simple(input)
    }
    # puts "Simple took: #{time.real * 1000}"
    assert missing == found

    found = nil
    time = Benchmark.measure {
      found = @arrays.missing_value_divide_and_conquer(input)
    }
    # puts "Divide and conquer took: #{time.real * 1000}"
    assert missing == found
  end
end