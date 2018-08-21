class LinkedListItem
  @parent = nil
  @child.nil?
  @value = nil

  attr_accessor :parent, :child, :value

  def initialize(value=nil, parent=nil, child=nil)
    @value = value
    @parent = parent
    @child = child
  end

  def is_head?
    @parent.nil?
  end

  def is_tail?
    @child.nil?
  end
end