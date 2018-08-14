require File.expand_path('../../test_helper', __FILE__)

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
end