require File.expand_path('../../test_helper', __FILE__)

class BinaryTreesTest < ActiveSupport::TestCase
  setup do
    @tree = BinaryTree.new(1)
  end

  test 'a tree with only a root node has no second largest value' do
    assert nil == @tree.second_largest_value
  end

  test 'find 2nd largest element in a binary tree' do
    left_node = @tree.create_node(2, @tree.root_node, true)
    node = @tree.create_node(6, left_node, true)
    node = @tree.create_node(20, node, true)
    node = @tree.create_node(11, node, true)
    right_node = @tree.create_node(3, @tree.root_node, false)
    node = @tree.create_node(9, right_node, true)
    node = @tree.create_node(13, right_node, false)
    node = @tree.create_node(21, node, false)
    node = @tree.create_node(17, node, false)

    assert 20 == @tree.second_largest_value
  end
end