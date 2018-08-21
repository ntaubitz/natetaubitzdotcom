require File.expand_path('../../test_helper', __FILE__)

class SortingTest < ActiveSupport::TestCase
  setup do
    @sorting = Sorting.new
  end

  test 'an array is merge sorted' do
    array = [38,27,43,3,9,82,10]
    @sorting.merge_sort(array)
    assert [3,9,10,27,38,43,82] == array
  end
end