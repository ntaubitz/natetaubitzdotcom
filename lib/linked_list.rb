class LinkedList
  @head = nil
  @tail = nil
  @count = nil

  attr_accessor :head, :tail, :count

  def initialize
    @count = 0
  end

  def add_to_head(value)
    add_to(value, @head)
  end

  def add_to_tail(value)
    add_to(value, @tail)
  end

  def add_to(value, node=nil, before=true)
    new_node = LinkedListItem.new(value)
    if @head.nil?
      @head = @tail = new_node
      @count = 1
      return new_node
    end

    if before
      # 1,8,9
      #   |
      #   7
      new_node.child = node
      new_node.parent = node.parent
      node.parent.child = new_node unless node.parent.nil?
      node.parent = new_node
      if new_node.is_head?
        @head = new_node
      end
    else
      # 1, 7, 9
      #    |
      #    8
      new_node.parent = node
      new_node.child = node.child
      node.child.parent = new_node unless node.child.nil?
      node.child = new_node
      if new_node.is_tail?
        @tail = new_node
      end
    end
    @count += 1
  end

  def remove(node)
    if node.is_head? && node.is_tail?
      @count = 0
      @head = @tail = nil
      return
    end

    if node.is_tail?
      @tail = node.parent
      node.parent.child = nil
    elsif node.is_head?
      @head = node.child
      node.child.parent = nil
    else
      node.parent.child = node.child
      node.child.parent = node.parent
    end
    @count -= 1
  end

  def empty?
    @head.nil?
  end

  def iterate
    return if @head.nil?
    node = @head
    while !node.nil?
      yield node
      node = node.child
    end
  end
end