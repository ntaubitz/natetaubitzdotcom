class BinaryTree
  @root_node = nil

  attr_accessor :root_node

  def initialize(value)
    @root_node = BinaryTreeNode.new(value)
  end

  def create_node(value, parent, left=true)
    node = BinaryTreeNode.new(value)
    parent.left = node if left
    parent.right = node unless left

    node
  end

  def second_largest_value
    return nil unless @root_node.has_children?

    values = all_values(@root_node).sort
    values[values.count - 2]
  end

  def all_values(node, values=nil)
    values = [] if values.nil?
    values << node.value
    all_values(node.left, values) if node.has_left?
    all_values(node.right, values) if node.has_right?
    values
  end
end