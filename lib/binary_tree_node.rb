class BinaryTreeNode
  @value = nil
  @left = nil
  @right = nil

  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end

  def has_children?
    return true unless @left.nil?
    return true unless @right.nil?
    false
  end

  def is_leaf?
    !has_left? && !has_right?
  end

  def has_left?
    !@left.nil?
  end

  def has_right?
    !@right.nil?
  end
end