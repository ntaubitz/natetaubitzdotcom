require File.expand_path('../../test_helper', __FILE__)

class HeapTest < ActiveSupport::TestCase
  setup do
    @heap = Heap.new
  end

  test'values are pushed and popped correctly' do
    @heap.push(1)
    @heap.push(5)
    @heap.push(3)
    @heap.push(7)
    @heap.push(9)

    assert 9 == @heap.pop
    assert 7 == @heap.pop
    assert 3 == @heap.pop
    assert 5 == @heap.pop
    assert 1 == @heap.pop
  end

  test 'nothing to pop is nil' do
    @heap.push(1)

    assert 1 == @heap.pop
    assert nil == @heap.pop
  end
end